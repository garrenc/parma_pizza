import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../screens/confirm_order_screen.dart';
import '../screens/tabs_screen.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true, textScaleFactor:1.0 ),
              child: child),
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            fontFamily: 'ComicSans',
          ),
          home: TabsScreen(0),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            ConfirmOrderScreen.routeName: (ctx) => ConfirmOrderScreen(),
          }),
    );
  }
}
