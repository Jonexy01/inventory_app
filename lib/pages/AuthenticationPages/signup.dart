import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../MyClasses/routes.dart';
import '../../MyWidgets/my_circular_text_button.dart';
import '../../MyWidgets/my_have_an_account_check.dart';
import '../../MyWidgets/my_rounded_input_field.dart';
import '../../MyWidgets/my_rounded_password_field.dart';
import '../../MyWidgets/or_divider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
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
                
              }),
              hintText: 'Enter email',
              icon: Icons.person,
            ),
            MyRoundPasswordField(
              onChanged: ((value) {
                
              }),
            ),
            MyCircularTextButton(
              text: 'Sign up', 
              press: () {}
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
    );
  }
}

