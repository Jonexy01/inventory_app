import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/MyClasses/routes.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';

import 'package:inventory_app/widgets/my_text_button_icon.dart';
import 'package:inventory_app/MyClasses/table_head.dart';
import 'package:inventory_app/widgets/navigation_drawer.dart';
//import 'package:inventory_app/presentation/waiting.dart';
//import 'package:inventory_app/core/services/auth.dart';
//import 'package:inventory_app/core/services/database.dart';
//import 'package:provider/provider.dart';
//import 'package:inventory_app/core/models/user_data_collection.dart';

//import '../../../core/models/user.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  //String? title = 'Welcome';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    final model = ref.read(homepageViewModelProvider.notifier);
    model.getToken();
    model.requestNotificationPermissions();
    super.initState();
  }
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authViewModelProvider).user;
    final model = ref.read(authViewModelProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Welcome ' + user!.displayName!),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await model.signout();
                context.router.replaceAll([const LandingPageRoute()]);
              },
              icon: const Icon(Icons.logout),
              tooltip: 'sign out',
            ),
          ],
        ),
        drawer: const NavigationDrawer(),
        body: Column(
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
                        child: const MyTextButtonIcon(
                          myText: "Low Stock",
                          myIcon: Icons.favorite,
                          routeName: AppRoute.lowStock,
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: const MyTextButtonIcon(
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
        ));
  }
}
