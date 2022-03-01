import 'package:flutter/material.dart';

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
              Text('Provide your details'),
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
            ],
          ),
        )
      ),
    );
  }
}