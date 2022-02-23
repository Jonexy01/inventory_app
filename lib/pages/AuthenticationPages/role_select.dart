import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/MyWidgets/my_circular_text_button.dart';
import 'package:inventory_app/services/auth.dart';


class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Container()),
          Text('Please choose your role'),
          Flexible(child: Container()),
          MyCircularTextButton(
            color: Colors.purple.shade600,
            text: 'Create as admin', 
            press: () {
              Navigator.pushReplacementNamed(context, AppRoute.home);
            }
          ),
          MyCircularTextButton(
            color: Colors.purple.shade300,
            text: 'Join an existing business', 
            press: () {
              
            }
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}