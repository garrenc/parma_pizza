import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parma_pizza/bloc/products_bloc.dart';
import 'package:parma_pizza/bloc/products_event.dart';
import 'package:parma_pizza/bloc/products_state.dart';
import 'package:parma_pizza/extensions/string.dart';
import 'package:parma_pizza/providers/product.dart';
import 'package:parma_pizza/screens/search_screen.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/header_clip.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> with AutomaticKeepAliveClientMixin {
  AutoScrollController? controller;
  ProductsBloc bloc = ProductsBloc();

  final List<bool> isSelected = [];
  final List<Product> items = [];
  final List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    bloc.add(ProductsFetch());
    controller = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 50, 0, MediaQuery.of(context).padding.bottom), axis: Axis.vertical);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsLoaded) {
          categories.addAll(state.categories);
          items.addAll(state.products);
          for (int i = 0; i < categories.length; i++) {
            isSelected.add(false);
          }
        }
      },
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Меню'),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchScreen()),
                    );
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          backgroundColor: Colors.white,
          body: ListView(
            controller: controller,
            children: <Widget>[
              const HeaderClip(),
              const SizedBox(height: 20),
              StickyHeader(
                header: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.7), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 20)),
                        ],
                      ),
                      height: 32,
                      child: SizedBox(
                        height: 32,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) => categoriesButton(categories[i]["scrollIndex"], i),
                          itemCount: categories.length,
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
                content: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: items.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            ...List.generate(
                              items.length,
                              (index) {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: controller!,
                                  index: index,
                                  child: Column(
                                    children: [
                                      ProductItem(
                                        product: items[index],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      if (index != items.length - 1)
                                        const Divider(
                                          indent: 15,
                                          endIndent: 15,
                                          color: Colors.blueGrey,
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _scrollToIndex(int index) async {
    await controller!.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  Widget categoriesButton(int scrollIndex, int index) {
    return GestureDetector(
      onTap: () {
        _scrollToIndex(scrollIndex);
        setState(
          () {
            for (int indexBtn = 0; indexBtn < isSelected.length; indexBtn++) {
              if (indexBtn == index) {
                isSelected[indexBtn] = true;
                Timer(const Duration(milliseconds: 200), () {
                  setState(() {
                    isSelected[indexBtn] = false;
                  });
                });
              } else {
                isSelected[indexBtn] = false;
              }
            }
          },
        );
      },
      child: Container(
        height: 33,
        padding: const EdgeInsets.only(left: 15),
        child: Container(
            alignment: Alignment.center,
            height: 8.0,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: isSelected[index] ? Colors.orange.shade200 : Colors.grey.shade300,
            ),
            child: Text(
              categories[index]["name"].toString().capitalize(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected[index] ? Colors.orange.shade700 : Colors.black,
              ),
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
