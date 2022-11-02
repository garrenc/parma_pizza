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
  String input = '';
  TextEditingController controller = TextEditingController();

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
          body: state is ProductsLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: controller.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () => setState(() {
                                          controller.text = '';
                                          products = allProducts;
                                        }),
                                    icon: const Icon(Icons.clear))
                                : null,
                            hintText: 'Введите название товара',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: Colors.black)),
                          ),
                          onChanged: searchProduct,
                          controller: controller,
                        ),
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

      return productTitle.contains(controller.text.toLowerCase());
    }).toList();

    setState(() => products = suggestions);
  }
}
