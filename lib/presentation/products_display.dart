import 'package:flutter/material.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({ Key? key }) : super(key: key);

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products'), centerTitle: true,),
      body: const Center(child: Text("This displays product")),
    );
  }
}