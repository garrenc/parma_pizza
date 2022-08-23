import 'package:flutter/material.dart';
import 'package:parma_pizza/providers/product.dart';
import 'package:parma_pizza/providers/products.dart';
import 'package:parma_pizza/widgets/product_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> products;
  List<Product> allProducts;
  bool firstInstance = true;
  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<Products>(context);
    final items = itemsData.items;
    allProducts = items;
    if (firstInstance) {
      products = items;
      firstInstance = false;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Поиск'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Введите название товара',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black)),
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
                      id: product.id,
                      imageUrl: product.imageUrl,
                      price: product.price,
                      description: product.description,
                      title: product.title,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (index != items.length - 1)
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                        color: Colors.blueGrey,
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
  }

  void searchProduct(String query) {
    final suggestions = allProducts.where((product) {
      final productTitle = product.title.toLowerCase();
      final input = query.toLowerCase();

      return productTitle.contains(input);
    }).toList();

    setState(() => products = suggestions);
    print(products);
  }
}
