import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final int price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartItem(
    this.id,
    this.productId,
    this.imageUrl,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              leading: Image.network(imageUrl),
              title: Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            endIndent: 10,
            indent: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(price * quantity)} ₽',
                  style: TextStyle(fontSize: 17),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => cart.removeSingleItem(productId),
                        iconSize: 25,
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 17),
                      ),
                      IconButton(
                        onPressed: () =>
                            cart.addItem(productId, price, title, imageUrl),
                        iconSize: 25,
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
