import 'package:flutter/material.dart';

class StopoverPage extends StatelessWidget {
  const StopoverPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(height: 10),
          Text('Kindly confirm your role'),
        ],
      ),
    );
  }
}