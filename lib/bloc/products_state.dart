import 'package:parma_pizza/providers/product.dart';

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final List<Map<String, dynamic>> categories;

  ProductsLoaded({required this.products, required this.categories});
}

class InfoLoaded extends ProductsState {
  final String warning;
  final List<String> info;
  final String minimum;

  InfoLoaded({required this.warning, required this.info, required this.minimum});
}
