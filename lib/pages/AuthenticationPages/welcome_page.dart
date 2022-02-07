import 'package:flutter/material.dart';

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
              press: () {},
              color: Colors.purple.shade400,
            ),
            MyCircularTextButton(
              text: 'Sign up', 
              press: () {},
              color: Colors.purple.shade100,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

