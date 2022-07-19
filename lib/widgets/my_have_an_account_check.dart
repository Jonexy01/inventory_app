import 'package:flutter/material.dart';

class MyHaveAnAccountCheck extends StatelessWidget {

  final bool login;
  final VoidCallback? press;

  const MyHaveAnAccountCheck({
    Key? key, 
    this.login = true, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Don\'t have an account yet? ' : 'Already have an account? ',
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Sign up' : 'Sign in',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}