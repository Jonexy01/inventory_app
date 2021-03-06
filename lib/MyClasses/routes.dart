//import 'package:flutter/material.dart';

class AppRoute {

  /// This stores String static properties for the routes.
  AppRoute();

  static const String home = '/home';
  static const String loading = '/';
  static const String lowStock = 'productsDisplay';
  static const String productsDisplay = 'lowStockDisplay';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signin';
  static const String wrapper = '/wrapper';
  static const String roleSelect = '/roleSelect';
  static const String waiting = '/waiting';
  static const String statusSelect = '/statusSelect';

  // Copied code below keeps some pages in a Map
  
  //static Map<String, WidgetBuilder> define() {
  //  return {
  //    authLogin: (context) => Login(),
  //    autRegidter: (context) => Register(),

  //    menu: (context) => MenuScreen(),
  //  };
  //}

}