import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple.shade50,
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.amber,
          size: 50,
        ),
      ),
    );
  }
}