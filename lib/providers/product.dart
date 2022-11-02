import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  final String weight;

  Product({
    required this.weight,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
