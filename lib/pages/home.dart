import 'package:flutter/material.dart';

import 'package:inventory_app/MyWidgets/my_text_button_icon.dart';
import 'package:inventory_app/table_head.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                //width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: MyTextButtonIcon(myText: "Low Stock", myIcon: Icons.favorite, routeName: '/lowStockDisplay',)
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: MyTextButtonIcon(myText: 'Products', myIcon: Icons.accessibility, routeName: '/productsDisplay',)
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.purple[400],
                indent: 20,
                endIndent: 20,
                height: 20,
              ),
              Center(
                child: Text(
                  "Last sales transations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Table(
                  border: TableBorder(
                    verticalInside: BorderSide(
                      color: Colors.purple,
                      style: BorderStyle.solid,
                    ),
                  ),
                  children: [
                    MyTableProperties.headRow,
                  ],
                ),
              )
            ],
          ),
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}