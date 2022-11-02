import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parma_pizza/bloc/products_bloc.dart';
import 'package:parma_pizza/helpers/store_manager.dart';
import 'package:provider/provider.dart';

import '../screens/confirm_order_screen.dart';
import '../screens/tabs_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider(
      create: (context) => ProductsBloc(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
        ],
        child: MaterialApp(
            navigatorKey: StoreManager.navigatorKey,
            builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true, textScaleFactor: 1.0), child: child!),
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              fontFamily: 'ComicSans',
            ),
            home: const TabsScreen(0),
            routes: {
              CartScreen.routeName: (ctx) => const CartScreen(),
              ConfirmOrderScreen.routeName: (ctx) => const ConfirmOrderScreen(),
            }),
      ),
    );
  }
}
