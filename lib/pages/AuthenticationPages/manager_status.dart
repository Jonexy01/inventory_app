import 'package:flutter/material.dart';

class ManagerStatus extends StatefulWidget {
  const ManagerStatus({ Key? key }) : super(key: key);

  @override
  _ManagerStatusState createState() => _ManagerStatusState();
}

class _ManagerStatusState extends State<ManagerStatus> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            ],
          ),
        )
      ),
    );
  }
}