import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';

import '../../MyWidgets/my_circular_text_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Inventory App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.3,),
            MyCircularTextButton(
              text: 'Login',
              press: () {Navigator.pushReplacementNamed(context, AppRoute.login);},
              color: Colors.purple.shade400,
            ),
            MyCircularTextButton(
              text: 'Sign up', 
              press: () {Navigator.pushReplacementNamed(context, AppRoute.signup);},
              color: Colors.purple.shade100,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

