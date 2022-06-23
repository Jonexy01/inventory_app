import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/waiting.dart';
import 'package:inventory_app/core/services/auth.dart';

import '../../../MyClasses/routes.dart';
import '../../../widgets/my_circular_text_button.dart';
import '../../../widgets/my_have_an_account_check.dart';
import '../../../widgets/my_rounded_input_field.dart';
import '../../../widgets/my_rounded_password_field.dart';
import '../../../widgets/or_divider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

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
        width: double.infinity,
        height: size.height,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.3,),
              MyRoundedInputField(
                onChanged: ((value) {
                  email = value;
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
                text: 'Sign up', 
                press: () async {
                  error = '';
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      waiting = true;
                    });
                    dynamic result = await Future.any([
                      _auth.mySignUpWithEmailPassword(email, password),
                      Future.delayed(const Duration(seconds: 20), () {
                        setState(() {
                          error = "It is taking too long. Contact admin if network is okay";
                          waiting = false;
                        });
                      })
                    ]);
                    //;
                    if (result == null) {
                      setState(() {
                        error = 'Something went wrong';
                        waiting = false;
                      });
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoute.statusSelect);
                    }
                  }
                }
              ),
              SizedBox(height: 8,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14,),
              ),
              MyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacementNamed(context, AppRoute.login);
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.amber,
                      ),
                      shape: BoxShape.circle,
                    ),
                    // child: SvgPicture.asset(
                    //   'assets/icons/Facebook-f_Logo-Blue-Logo.wine.svg',
                    //   height: 20,
                    //   width: 20,
                    // ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

