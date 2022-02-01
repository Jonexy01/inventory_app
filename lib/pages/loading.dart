import 'package:flutter/material.dart';

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
      body: Center(child: Text("The Inventory App")),
    );
  }
}