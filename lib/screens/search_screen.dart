import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parma_pizza/bloc/products_bloc.dart';
import 'package:parma_pizza/bloc/products_event.dart';
import 'package:parma_pizza/bloc/products_state.dart';
import 'package:parma_pizza/providers/product.dart';
import 'package:parma_pizza/widgets/product_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> products = [];
  List<Product> allProducts = [];
  ProductsBloc bloc = ProductsBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(ProductsFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsLoaded) {
          allProducts = state.products;
          products = state.products;
        }
      },
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Поиск'),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Введите название товара',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.black)),
                  ),
                  onChanged: searchProduct,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    var product = products[index];

                    return Column(
                      children: [
                        ProductItem(
                          product: product,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  },
                  itemCount: products.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void searchProduct(String query) {
    final suggestions = allProducts.where((product) {
      final productTitle = product.title.toLowerCase();
      final input = query.toLowerCase();

      return productTitle.contains(input);
    }).toList();

    setState(() => products = suggestions);
  }
}
