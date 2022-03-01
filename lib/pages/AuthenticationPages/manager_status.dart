import 'package:flutter/material.dart';
import 'package:inventory_app/MyWidgets/my_circular_text_button.dart';
import 'package:inventory_app/MyWidgets/my_have_an_account_check.dart';

import '../../MyWidgets/my_rounded_input_field.dart';

class ManagerStatus extends StatefulWidget {
  const ManagerStatus({ Key? key }) : super(key: key);

  @override
  _ManagerStatusState createState() => _ManagerStatusState();
}

class _ManagerStatusState extends State<ManagerStatus> {

  final _formKey = GlobalKey<FormState>();

  //text field state
  String name = '';
  String businessName = '';
  String status = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please provide your details'),
              Spacer(),
              Spacer(),
              MyRoundedInputField(
                onChanged: ((value) {
                  name = value;
                }),
                hintText: 'Enter your name',
                icon: Icons.person,
              ),
              SizedBox(height: 10,),
              MyRoundedInputField(
                onChanged: ((value) {
                  businessName = value;
                }),
                hintText: 'Enter your business name',
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(child: Text('Manager'), value: 'Manager',),
                  DropdownMenuItem(child: Text('Staff'), value: 'Staff',),
                ], 
                value: status,
                hint: Text('Select your status'),
                onChanged: (selectedValue) {
                  if (selectedValue is String) {
                    setState(() {
                      status = selectedValue;
                    });
                  }
                },
                iconSize: 20,
                iconEnabledColor: Colors.amber,
                isExpanded: true,
              ),
              Spacer(),
              MyCircularTextButton(
                text: '', 
                press: () {},
              ),
              Spacer(),
            ],
          ),
        )
      ),
    );
  }
}