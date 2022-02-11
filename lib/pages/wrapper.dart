import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/user.dart';
import 'package:inventory_app/pages/AuthenticationPages/welcome_page.dart';
import 'package:inventory_app/pages/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<MyUser?>(context);

    //return either home or authenticate widget
    if (currentUser == null) {
      return WelcomeScreen();
    } else {
      return Home(title: 'Welcome to Inventory App');
    }
    
  }
}