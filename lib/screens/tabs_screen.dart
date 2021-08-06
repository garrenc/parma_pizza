import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/products_overview_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/info_screen.dart';

// ignore: must_be_immutable
class TabsScreen extends StatefulWidget {
  int selectedPageIndex = 0;

  TabsScreen(this.selectedPageIndex);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    ProductsOverviewScreen(),
    InfoScreen(),
    CartScreen(),
  ];

  void _selectPage(int index) {
    setState(() {
      widget.selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: _pages[widget.selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: widget.selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_pizza_outlined), label: 'Меню'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_support_outlined), label: 'Информация'),
          BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Colors.orange,
                elevation: 0,
                shape: BadgeShape.circle,
                padding: EdgeInsets.all(5),
                badgeContent: Text(
                  cart.totalItemCount.toString(),
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                child: Icon(
                  Icons.shopping_basket_outlined,
                ),
              ),
              label: 'Корзина')
        ],
      ),
    );
  }
}
