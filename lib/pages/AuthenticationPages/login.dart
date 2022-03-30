//import 'dart:ffi';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/MyWidgets/my_circular_text_button.dart';
import 'package:inventory_app/MyWidgets/my_text_field_container.dart';
import 'package:inventory_app/pages/waiting.dart';
import 'package:inventory_app/services/auth.dart';

import '../../MyWidgets/my_have_an_account_check.dart';
import '../../MyWidgets/my_rounded_input_field.dart';
import '../../MyWidgets/my_rounded_password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool waiting = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return waiting ? WaitingPage() : Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Form(
          key: _formKey,
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
                  error = '';
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      waiting = true;
                    });
                    dynamic result = await Future.any([
                      _auth.mySigninWithEmailPassword(email, password),
                      Future.delayed(const Duration(seconds: 20), () {
                        setState(() {
                          error = "It is taking too long. Contact admin if network is okay";
                          waiting = false;
                        });
                      })
                    ]);
                    if (result == null) {
                      setState(() {
                        error = 'Something went wrong';
                        waiting = false;
                      });
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoute.home);
                    }
                  }
                }
              ),
              MyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacementNamed(context, AppRoute.signup);
                },
              ),
              SizedBox(height: 8,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


