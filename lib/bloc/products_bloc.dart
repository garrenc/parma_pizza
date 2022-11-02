import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parma_pizza/bloc/products_event.dart';
import 'package:parma_pizza/bloc/products_state.dart';
import 'package:parma_pizza/extensions/logger.dart';
import 'package:parma_pizza/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final url = 'https://parmapizza.ru/parmajson.php';
  ProductsBloc() : super(ProductsLoading()) {
    on<ProductsFetch>((event, emit) async {
      try {
        final response = await http.get(Uri.parse(url));
        final extractedDataMap = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final categoryData = extractedDataMap['site']['group'];
        final List<Product> loadedProducts = [];
        List<Map<String, dynamic>> categories = [];
        Map<String, dynamic> loadedCategories = {};
        num scrollLength = 0;
        for (var category in categoryData) {
          loadedCategories["name"] = (category['@attributes']['name']);
          loadedCategories["scrollIndex"] = scrollLength;
          scrollLength += category["item"].length;
          categories.add(loadedCategories);
          loadedCategories = {};
          for (var item in category['item']) {
            loadedProducts.add(Product(
                weight: item['grm'],
                id: item['id'],
                title: item['name'],
                description: item['descr'] is String ? item['descr'].toString() : '',
                price: int.parse(item['price']),
                imageUrl: item['image']));
          }
        }
        emit(ProductsLoaded(categories: categories, products: loadedProducts));
      } catch (e) {
        Logger.log(e.toString());
      }
    });
    on<InfoFetch>((event, emit) async {
      final response = await http.get(Uri.parse('http://217.25.93.159:8080/delivery'));
      final extractedDataMap = json.decode(response.body) as Map<String, dynamic>;
      emit(InfoLoaded(warning: extractedDataMap['warning'], minimum: extractedDataMap['minimum'], info: (extractedDataMap['info'] as List).map((e) => e.toString()).toList()));
    });
  }
}
