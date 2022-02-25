import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';

import 'package:inventory_app/MyWidgets/my_text_button_icon.dart';
import 'package:inventory_app/MyClasses/table_head.dart';
import 'package:inventory_app/services/auth.dart';
import 'package:inventory_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:inventory_app/MyClasses/user_data_collection.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.title}) : super(key: key);

  String? title = 'Welcome';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    //String nameOfUser = (Provider.of<MyUserData?>(context))!.name ?? 'not available';
    MyUserData myVariable = Provider.of<MyUserData>(context);
    String? nameOfUser = myVariable.name;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title! + ' ' + nameOfUser!),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await _auth.mySignOut(context, AppRoute.wrapper);
              },
              icon: Icon(Icons.logout),
              tooltip: 'sign out',
            ),
          ],
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
                          child: MyTextButtonIcon(
                            myText: "Low Stock",
                            myIcon: Icons.favorite,
                            routeName: AppRoute.lowStock,
                          )),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: MyTextButtonIcon(
                            myText: 'Products',
                            myIcon: Icons.accessibility,
                            routeName: AppRoute.productsDisplay,
                          )),
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
