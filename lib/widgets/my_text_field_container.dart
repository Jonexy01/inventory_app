import 'package:flutter/material.dart';

class MyTextFieldContainer extends StatelessWidget {

  final Widget? child;

  const MyTextFieldContainer({
    Key? key, 
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}