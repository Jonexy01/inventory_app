//import 'dart:ffi';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/MyWidgets/my_circular_text_button.dart';
import 'package:inventory_app/MyWidgets/my_text_field_container.dart';

import '../../MyWidgets/my_have_an_account_check.dart';
import '../../MyWidgets/my_rounded_input_field.dart';
import '../../MyWidgets/my_rounded_password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.3,),
              MyRoundedInputField(
                onChanged: ((value) {
                  setState(() {
                    email = value;
                  });
                }),
                hintText: 'Enter email',
                icon: Icons.person,
              ),
              MyRoundPasswordField(
                onChanged: ((value) {
                  password = value;
                }),
              ),
              MyCircularTextButton(
                text: 'Login', 
                press: () async {
        
                }
              ),
              MyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacementNamed(context, AppRoute.signup);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


