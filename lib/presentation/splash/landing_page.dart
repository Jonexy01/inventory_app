import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/router/app_router.dart';

import '../../widgets/my_circular_text_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
            const Text(
              'Welcome to Inventory App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
            ),
            RoundedTextButton(
              text: 'Login',
              press: () {
                context.router.push(const LoginPageRoute());
                //Navigator.pushReplacementNamed(context, AppRoute.login);
              },
              color: Colors.purple.shade400,
            ),
            RoundedTextButton(
              text: 'Sign up',
              press: () {
                context.router.push(const SignupPageRoute());
                //Navigator.pushReplacementNamed(context, AppRoute.signup);
              },
              color: Colors.purple.shade100,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
