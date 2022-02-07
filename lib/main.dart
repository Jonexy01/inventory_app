import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/pages/AuthenticationPages/welcome_page.dart';

import 'package:inventory_app/pages/home.dart';
import 'package:inventory_app/pages/loading.dart';
import 'package:inventory_app/pages/low_stock_display.dart';
import 'package:inventory_app/pages/products_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: AppRoute.welcome,
      routes: {
        //AppRoute.loading: (context) => Loading(), 
        AppRoute.home: (context) => MyHomePage(title: 'Welcome to Inventory App'),
        AppRoute.productsDisplay: (context) => ProductDisplay(),
        AppRoute.lowStock: (context) => LowStockDisplay(),
        AppRoute.welcome: (context) => WelcomeScreen(),
      },
    );
  }
}