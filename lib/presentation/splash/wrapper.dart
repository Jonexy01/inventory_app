import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/user.dart';
import 'package:inventory_app/presentation/Splash/landing_page.dart';
import 'package:provider/provider.dart';

import '../home/homepage/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<MyUser?>(context);

    //return either home or authenticate widget
    if (currentUser == null) {
      return LandingPage();
    } else {
      return HomePage();
    }
    
  }
}