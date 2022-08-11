import 'package:flutter/material.dart';

class SecondaryWaitPage extends StatelessWidget {
  const SecondaryWaitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Text('Please follow up on the primary user for approval'),
            SizedBox(height: 10),
            Text('You will be automatically logged in once the user approves')
          ],
        ),
      ),
    );
  }
}