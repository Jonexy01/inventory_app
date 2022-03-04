import 'package:flutter/material.dart';
import 'package:inventory_app/MyWidgets/my_circular_text_button.dart';
import 'package:inventory_app/MyWidgets/my_have_an_account_check.dart';

import '../../MyClasses/routes.dart';
import '../../MyWidgets/my_rounded_input_field.dart';

class StatusSelectPage extends StatefulWidget {
  const StatusSelectPage({ Key? key }) : super(key: key);

  @override
  _StatusSelectPageState createState() => _StatusSelectPageState();
}

class _StatusSelectPageState extends State<StatusSelectPage> {

  final _formKey = GlobalKey<FormState>();

  //text field state
  String name = '';
  String businessName = '';
  String status = '';
  String managerEmail = '';
  bool isStaffSelected = false;
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
                onTap: () {
                  if(status == 'Staff') {
                    setState(() {
                      isStaffSelected = true;
                    });
                  }
                },
                iconSize: 20,
                iconEnabledColor: Colors.amber,
                isExpanded: true,
              ),
              isStaffSelected ? MyRoundedInputField(
                onChanged: (value) {
                  managerEmail = value;
                },
                hintText: 'Enter manager\'s email',
              ) : Container(),
              Spacer(),
              MyCircularTextButton(
                text: '', 
                press: () {
                  Navigator.pushReplacementNamed(context, AppRoute.home);
                },
              ),
              Spacer(),
            ],
          ),
        )
      ),
    );
  }
}