import 'package:flutter/material.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';

class SecondaryUserApproval extends StatelessWidget {
  const SecondaryUserApproval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Approval Status'),),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text('Secondary User'),
          const SizedBox(height: 20),
          const Text('Approval Status'),
          const SizedBox(height: 20),
          RoundedTextButton(text: 'Approve', press: () {}),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}