import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/user.dart';
import 'package:inventory_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/pages/AuthenticationPages/login.dart';
import 'package:inventory_app/pages/AuthenticationPages/signup.dart';
import 'package:inventory_app/pages/AuthenticationPages/welcome_page.dart';
import 'package:inventory_app/pages/home.dart';
import 'package:inventory_app/pages/loading.dart';
import 'package:inventory_app/pages/low_stock_display.dart';
import 'package:inventory_app/pages/products_display.dart';
import 'package:inventory_app/pages/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Inventory App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: {
          AppRoute.wrapper:(context) => Wrapper(),
          AppRoute.loading: (context) => Loading(), 
          AppRoute.home: (context) => Home(title: 'Inventory App'),
          AppRoute.productsDisplay: (context) => ProductDisplay(),
          AppRoute.lowStock: (context) => LowStockDisplay(),
          AppRoute.welcome: (context) => WelcomeScreen(),
          AppRoute.login:(context) => LoginPage(),
          AppRoute.signup:(context) => SignupPage(),
        },
      ),
    );
  }
}