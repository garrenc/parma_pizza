import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/products_overview_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/info_screen.dart';

class TabsScreen extends StatefulWidget {
  final int selectedPageIndex;

  const TabsScreen(this.selectedPageIndex, {super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int pageIndex = 0;
  PageController? controller;
  final List<Widget> _pages = [
    const ProductsOverviewScreen(),
    const InfoScreen(),
    const CartScreen(),
  ];

  @override
  void initState() {
    super.initState();

    pageIndex = widget.selectedPageIndex;
    controller = PageController(initialPage: pageIndex);
  }

  void _selectPage(int index) {
    setState(() {
      controller!.jumpToPage(index);
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: PageView(controller: controller, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: pageIndex,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.local_pizza_outlined), label: 'Меню'),
          const BottomNavigationBarItem(icon: Icon(Icons.contact_support_outlined), label: 'Информация'),
          BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Colors.orange,
                elevation: 0,
                shape: BadgeShape.circle,
                padding: const EdgeInsets.all(5),
                badgeContent: Text(
                  cart.totalItemCount.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                child: const Icon(
                  Icons.shopping_basket_outlined,
                ),
              ),
              label: 'Корзина')
        ],
      ),
    );
  }
}
