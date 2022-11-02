import 'package:flutter/material.dart';
import 'package:parma_pizza/helpers/store_manager.dart';
import 'package:parma_pizza/providers/product.dart';
import 'package:parma_pizza/widgets/button.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

import '../screens/tabs_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: height / 2.5,
                width: double.infinity,
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.product.weight,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              width: double.infinity,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            ButtonApp(
              'В корзину за ${widget.product.price.toStringAsFixed(0)} ₽',
              () {
                cart.addItem(widget.product.id, widget.product.price, widget.product.title, widget.product.imageUrl);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Предмет добавлен в корзину!',
                    ),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'КОРЗИНА',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          StoreManager.navigatorKey.currentContext!,
                          MaterialPageRoute(builder: (context) => const TabsScreen(2)),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
