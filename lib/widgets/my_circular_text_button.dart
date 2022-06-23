import 'package:flutter/material.dart';

class MyCircularTextButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color color, textColor;
  
  const MyCircularTextButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.purple,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                vertical: 20, 
                horizontal: 40,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(color)
          ),
          onPressed: press, 
          child: Text(
            text,
            style: TextStyle(
              letterSpacing: 5,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}