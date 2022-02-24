import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/user.dart';
import 'package:inventory_app/pages/AuthenticationPages/role_select.dart';
import 'package:inventory_app/pages/waiting.dart';
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
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAqQQhHRleReWCFv5rmx_oY8NKNdnNCM04",
      authDomain: "inventory-app-720e2.firebaseapp.com",
      projectId: "inventory-app-720e2",
      storageBucket: "inventory-app-720e2.appspot.com",
      messagingSenderId: "430439182152",
      appId: "1:430439182152:web:10574c66f19a51d691cd7d",
      measurementId: "G-TG49M3JXTH"
    )
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

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
          AppRoute.home: (context) => Home(title: 'Welcome'),
          AppRoute.productsDisplay: (context) => ProductDisplay(),
          AppRoute.lowStock: (context) => LowStockDisplay(),
          AppRoute.welcome: (context) => WelcomeScreen(),
          AppRoute.login:(context) => LoginPage(),
          AppRoute.signup:(context) => SignupPage(),
          AppRoute.roleSelect:(context) => RoleSelectPage(),
          AppRoute.waiting: (context) => WaitingPage(),
        },
      ),
    );
  }
}