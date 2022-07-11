import 'package:flutter/material.dart';

import 'my_text_field_container.dart';

class RoundPasswordField extends StatelessWidget {

  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;

  const RoundPasswordField({
    Key? key, 
    this.onChanged,
    this.onSaved,
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
        onSaved: onSaved,
        controller: controller,
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