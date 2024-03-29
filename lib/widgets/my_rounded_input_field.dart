import 'package:flutter/material.dart';

import 'my_text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon,
      this.onChanged,
      this.controller,
      this.validator,
      this.keyboardType,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: TextFormField(
        validator: validator ?? (value) => null,
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.amber,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
