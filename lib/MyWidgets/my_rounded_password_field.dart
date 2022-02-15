import 'package:flutter/material.dart';

import 'my_text_field_container.dart';

class MyRoundPasswordField extends StatelessWidget {

  final ValueChanged? onChanged;

  const MyRoundPasswordField({
    Key? key, 
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextFieldContainer(
      child: TextFormField(
        validator: ((value) => value!.length < 6 ? 'Enter a minimum of 6 characters' : null),
        onChanged: onChanged,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.amber,
          ),
          suffixIcon: Icon(
            Icons.visibility, 
            color: Colors.amber,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}