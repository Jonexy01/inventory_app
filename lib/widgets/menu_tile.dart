import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/menu_item_model.dart';
//import 'package:inventory_app/router/app_router.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({ Key? key, required this.menuItem }) : super(key: key);

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: menuItem.leading,
      title: Text(menuItem.titleText!),
      onTap: () {
        context.router.pop();
        menuItem.onTap;
        context.router.push(menuItem.route!);
      }
    );
  }
}