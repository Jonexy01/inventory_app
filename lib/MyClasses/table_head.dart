import 'package:flutter/material.dart';

class MyTableProperties {

  MyTableProperties (TableRow headRow);
  
  static TableRow headRow = TableRow(
    decoration: BoxDecoration(
      color: Colors.purple[200],
    ),
    children: const [
      Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          "Product",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          "Type",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          "Price",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          "Quantity",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          "Date",
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}