import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  //_navigatehome() async {
    //await Future.delayed(Duration(milliseconds: 1500));
    //Navigator.pushReplacementNamed(context, '/home');
  //}

  @override
  void initState() {
    super.initState();
    //_navigatehome();
    Future.delayed(Duration(seconds: 5), () {Navigator.pushReplacementNamed(context, '/home');});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFoldingCube(
              color: Colors.white,
              size: 100.0,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "The Inventory App",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),
              ),
          ],
        )
        ),
    );
  }
}