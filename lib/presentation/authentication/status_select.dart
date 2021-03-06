import 'package:flutter/material.dart';
import 'package:inventory_app/Widgets/my_circular_text_button.dart';
import 'package:inventory_app/core/services/database.dart';

import '../../MyClasses/routes.dart';
import '../../core/models/user.dart';
import '../../widgets/my_rounded_input_field.dart';
import 'package:provider/provider.dart';

import '../waiting.dart';

class StatusSelectPage extends StatefulWidget {
  const StatusSelectPage({ Key? key }) : super(key: key);

  @override
  _StatusSelectPageState createState() => _StatusSelectPageState();
}

class _StatusSelectPageState extends State<StatusSelectPage> {

  final _formKey = GlobalKey<FormState>();
  bool waiting = false;

  //text field state
  String name = '';
  String businessName = '';
  String status = '';
  String managerEmail = '';
  bool isStaffSelected = false;
  String error = '';

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<MyUser?>(context);
    DatabaseService dbInstance = DatabaseService(uid: currentUser!.uid);

    return waiting ? const WaitingPage() : Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please provide your details'),
            const Spacer(),
            const Spacer(),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: const Text('Select status'), 
                  value: '',
                  onTap: () {setState(() {
                    isStaffSelected = false;
                  });},
                ),
                DropdownMenuItem(
                  child: const Text('Manager'), 
                  value: 'Manager',
                  onTap: () {setState(() {
                    isStaffSelected = false;
                  });},
                ),
                DropdownMenuItem(
                  child: const Text('Staff'), 
                  value: 'Staff',
                  onTap: () {setState(() {
                    isStaffSelected = true;
                  });},
                ),
              ], 
              value: status,
              hint: const Text('Select your status'),
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
            const SizedBox(height: 10,),
            RoundedInputField(
              onChanged: ((value) {
                name = value;
              }),
              hintText: 'Enter your name',
              icon: Icons.person,
            ),
            const SizedBox(height: 10,),
            isStaffSelected ? RoundedInputField(
              onChanged: (value) {
                managerEmail = value;
              },
              hintText: 'Enter manager\'s email',
            ) : RoundedInputField(
              onChanged: ((value) {
                businessName = value;
              }),
              hintText: 'Enter your business name',
            ),
            const Spacer(),
            RoundedTextButton(
              text: 'Continue', 
              press: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    waiting = true;
                  });
                  if(status == 'Manager') {
                    await dbInstance.updateUserDataNameRole(
                      name: name, status: status, businessName: businessName
                    );
                    Navigator.pushReplacementNamed(context, AppRoute.home);
                  } else if(status == 'Staff') {
                    await dbInstance.updateUserDataNameRole(name: name, status: status);
                    dynamic linkManager = await dbInstance.createSubuserUnderUser(name, managerEmail, status);
                    if (linkManager == SubUserResult.errorEncountered) {
                      setState(() {
                        error = 'Something went wrong. Ensure Manager;s email is correct';
                        waiting = false;
                      });
                    } else if (linkManager == SubUserResult.notManagerEmail) {
                      setState(() {
                        error = 'Something went wrong. Provided email may not belong to a Manager';
                        waiting = false;
                      });
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoute.home);
                    }
                  } else{
                    setState(() {
                      error = 'Something went wrong';
                      waiting = false;
                    });
                    
                  }
                }
                
              },
            ),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 14,),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}