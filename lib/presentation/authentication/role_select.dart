import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';


class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('Please choose your role'),
            Spacer(),
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
      ),
    );
  }
}