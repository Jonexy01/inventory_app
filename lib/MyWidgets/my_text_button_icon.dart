import 'package:flutter/material.dart';


class MyTextButtonIcon extends StatelessWidget {
  
  final String myText;
  IconData myIcon;
  String routeName;
  
  /// This creates my unique TextButton.icon. Expected to take two parameters.
  MyTextButtonIcon({
    Key? key,
    required this.myText,
    required this.myIcon,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 20.0),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.purple[100],
        ),
      ),
      onPressed: () {Navigator.pushNamed(context, routeName);},
      icon: Icon(myIcon),
      label: Text(myText),
    );
  }
}