import 'package:flutter/material.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';

class StopoverAddUserPage extends StatelessWidget {
  const StopoverAddUserPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text('Kindly provide information'),
            const SizedBox(height: 10),
            const RoundedInputField(
              hintText: 'Enter the email of the primary user',
            ),
            const SizedBox(height: 10),
            RoundedTextButton(
              text: 'Proceed',
              press: () {},
            ),
            const SizedBox(height: 10),
            const Text('''An email will be sent to the primary user for approval. 
            You will be automatically logged in once the user approves'''),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}