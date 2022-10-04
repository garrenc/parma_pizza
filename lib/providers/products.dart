import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Map<String, dynamic>> _categories = [];
  static const url = 'https://parmapizza.ru/parmajson.php';
  Future<void> fetchAndSetProducts() async {
    final response = await http.get(Uri.parse(url));
    final extractedDataMap = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final categoryData = extractedDataMap['site']['group'];
    final List<Product> loadedProducts = [];
    for (var item in categoryData) {
      loadedProducts.add(Product(
          weight: item['item']['grm'],
          id: item['item']['id'],
          title: item['item']['name'],
          description: item['item']['descr'] is String ? item['item']['descr'].toString() : '',
          price: int.parse(item['item']['price']),
          imageUrl: item['item']['image']));
    }
    _items = loadedProducts;
    notifyListeners();
  }

  Future<void> fetchAndSetCategories() async {
    try {
      final response = await http.get(Uri.parse(url));
      final extractedDataMap = await json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      List<Map<String, dynamic>> categories = [];
      Map<String, dynamic> loadedCategories = {};
      final categoryData = extractedDataMap['site']['group'];
      int scrollLength = 0;
      for (var item in categoryData) {
        loadedCategories["name"] = (item['@attributes']['name']);
        loadedCategories["scrollIndex"] = scrollLength;
        scrollLength += item["item"].length;
        categories.add(loadedCategories);
        loadedCategories = {};
      }
      _categories = categories;
    } catch (e) {
      print(e);
    }
  }

  List<Product> get items {
    return [..._items];
  }

  List<Map<String, dynamic>> get categories {
    return [..._categories];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
