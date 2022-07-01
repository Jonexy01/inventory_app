import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/local_database/hive_keys.dart';
import 'package:inventory_app/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyAqQQhHRleReWCFv5rmx_oY8NKNdnNCM04",
    //   authDomain: "inventory-app-720e2.firebaseapp.com",
    //   projectId: "inventory-app-720e2",
    //   storageBucket: "inventory-app-720e2.appspot.com",
    //   messagingSenderId: "430439182152",
    //   appId: "1:430439182152:web:10574c66f19a51d691cd7d",
    //   measurementId: "G-TG49M3JXTH"
    // )
  );
  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key,}) : super(key: key);
  final _appRouter = AppRouter(); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(    
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routerDelegate: _appRouter.delegate(),    
      routeInformationParser: _appRouter.defaultRouteParser(),    
    );    
  }
}




//flutter packages pub run build_runner build --delete-conflicting-outputs