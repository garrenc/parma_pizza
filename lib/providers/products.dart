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
    final extractedDataMap =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final categoryData = extractedDataMap['site']['group'];
    final List<Product> loadedProducts = [];
    for (int i = 0; i < categoryData.length; i++) {
      if (i == 3 || i == 6) {
        loadedProducts.add(Product(
            weight: categoryData[i]['item']['grm'],
            id: categoryData[i]['item']['id'],
            title: categoryData[i]['item']['name'],
            description: categoryData[i]['item']['descr'] is String
                ? categoryData[i]['item']['descr'].toString()
                : '',
            price: int.parse(categoryData[i]['item']['price']),
            imageUrl: categoryData[i]['item']['image']));
      } else
        for (int j = 0; j < categoryData[i]['item'].length; j++) {
          loadedProducts.add(Product(
              weight: categoryData[i]['item'][j]['grm'],
              id: categoryData[i]['item'][j]['id'],
              title: categoryData[i]['item'][j]['name'],
              description: categoryData[i]['item'][j]['descr'] is String
                  ? categoryData[i]['item'][j]['descr'].toString()
                  : '',
              price: int.parse(categoryData[i]['item'][j]['price']),
              imageUrl: categoryData[i]['item'][j]['image']));
        }
    }
    _items = loadedProducts;
    notifyListeners();
  }

  Future<void> fetchAndSetCategories() async {
    try {
    final response = await http.get(Uri.parse(url));
    final extractedDataMap =
    await json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    List<Map<String, dynamic>> categories = [];
    Map<String, dynamic> loadedCategories = {};
    final categoryData = extractedDataMap['site']['group'];
    int i = 0;
    for (var item in categoryData){
      loadedCategories["name"] = (item['@attributes']['name']);
      loadedCategories["itemsLength"] = item["item"].length;
      categories.isEmpty ? loadedCategories["scrollIndex"] = 0 :
      loadedCategories["scrollIndex"] = categories[i-1]["itemsLength"];
      categories.add(loadedCategories);
      loadedCategories = {};
      i++;
    }
    _categories = categories;}
    catch(e){
      print(e);
    }
}

  List<Product> get items {
    return [..._items];
  }

  List<Map<String,dynamic>> get categories {
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


