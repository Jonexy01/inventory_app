import 'package:flutter/material.dart';

class LowStockDisplay extends StatefulWidget {
  const LowStockDisplay({ Key? key }) : super(key: key);

  @override
  _LowStockDisplayState createState() => _LowStockDisplayState();
}

class _LowStockDisplayState extends State<LowStockDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Low Stock'), centerTitle: true,),
      body: const Center(child: Text("This displays low stock")),
    );
  }
}