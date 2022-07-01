import 'package:flutter/material.dart';

import 'my_text_field_container.dart';

class MyRoundPasswordField extends StatelessWidget {

  final ValueChanged? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;

  const MyRoundPasswordField({
    Key? key, 
    this.onChanged,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: const Icon(
            Icons.lock,
            color: Colors.amber,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}