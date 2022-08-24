import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parma_pizza/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../widgets/header_clip.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final scrollDirection = Axis.vertical;
  AutoScrollController controller;

  List<bool> isSelected = [
    false,
    false,
  ];
  List<Map<String,dynamic>> categories = [];

  @override
  void initState() {
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0,50, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Products>(context, listen: false).fetchAndSetCategories();
    Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    final itemsData = Provider.of<Products>(context);
    final items = itemsData.items;
    categories = itemsData.categories;
    return Scaffold(
      appBar: AppBar(
        title: Text('Меню'),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: scrollDirection,
        controller: controller,
        children: <Widget>[
          HeaderClip(context: context),
          StickyHeader(
            header: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 20)),
                    ],
                  ),
                  height: 32,
                    child: Container(
                      height: 32,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) => categoriesButton(categories[i]["scrollIndex"] , i),
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
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ...List.generate(
                    items.length,
                    (index) {
                      return AutoScrollTag(
                        key: ValueKey(index),
                        controller: controller,
                        index: index,
                        child: Column(
                          children: [
                            ProductItem(
                              id: items[index].id,
                              imageUrl: items[index].imageUrl,
                              price: items[index].price,
                              description: items[index].description,
                              title: items[index].title,
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
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index  ,
        preferPosition: AutoScrollPosition.begin);
  }
  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
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
                Timer(Duration(milliseconds: 200), () {
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
        padding: EdgeInsets.only(left: 15),
        child: Container(
          alignment: Alignment.center,
          height: 8.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: isSelected[index]
                ? Colors.orange.shade200
                : Colors.grey.shade300,
          ),
          child: Text(
                capitalize(categories[index]["name"]),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color:
                  isSelected[index] ? Colors.orange.shade700 : Colors.black,
                ),
              )

          ),
        ),

    );
  }
}
