import 'package:flutter/material.dart';

import 'my_text_field_container.dart';

class MyRoundedInputField extends StatelessWidget {

  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;

  const MyRoundedInputField({
    Key? key, this.hintText, this.icon, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: TextFormField(
        validator: (value) => value!.isEmpty ? 'Enter an email' : null,
        onChanged: onChanged,
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