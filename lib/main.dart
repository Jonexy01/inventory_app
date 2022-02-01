import 'package:flutter/material.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(), 
        '/home': (context) => MyHomePage(title: 'Welcome to Inventory App'),
        '/productsDisplay': (context) => ProductDisplay(),
        '/lowStockDisplay': (context) => LowStockDisplay(),
      },
    );
  }
}