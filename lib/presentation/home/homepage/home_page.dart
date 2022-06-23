import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';

import 'package:inventory_app/widgets/my_text_button_icon.dart';
import 'package:inventory_app/MyClasses/table_head.dart';
import 'package:inventory_app/presentation/waiting.dart';
import 'package:inventory_app/core/services/auth.dart';
import 'package:inventory_app/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:inventory_app/core/models/user_data_collection.dart';

import '../../../core/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  //String? title = 'Welcome';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<MyUser?>(context);

    //String nameOfUser = (Provider.of<MyUserData?>(context))!.name ?? 'not available';
    // MyUserData myVariable = Provider.of<MyUserData>(context);
    // String? nameOfUser = myVariable.name;

    return StreamBuilder<MyUserData>(
      stream: DatabaseService(uid: currentUser!.uid).currentUserDocument,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          MyUserData? userDoc = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('Welcome ' + userDoc!.name!),
              actions: <Widget>[
                IconButton(
                  onPressed: () async {
                    await _auth.mySignOut(context, AppRoute.wrapper);
                  },
                  icon: const Icon(Icons.logout),
                  tooltip: 'sign out',
                ),
              ],
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    //width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              child: MyTextButtonIcon(
                                myText: "Low Stock",
                                myIcon: Icons.favorite,
                                routeName: AppRoute.lowStock,
                              )),
                        ),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(10),
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
                  const Center(
                    child: Text(
                      "Last sales transations",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Table(
                      border: const TableBorder(
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
            )
          );
        } else {
          return const WaitingPage();
        }
        
      }
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
