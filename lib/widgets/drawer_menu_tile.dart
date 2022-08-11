import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/drawer_menu_item_model.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/providers/app_providers.dart';
//import 'package:inventory_app/router/app_router.dart';

class DrawerMenuTile extends ConsumerStatefulWidget {
  const DrawerMenuTile({ Key? key, required this.menuItem }) : super(key: key);

  final DrawerMenuItem menuItem;

  @override
  ConsumerState<DrawerMenuTile> createState() => _DrawerMenuTileState();
}

class _DrawerMenuTileState extends ConsumerState<DrawerMenuTile> {
  @override
  Widget build(BuildContext context) {
    final model = ref.read(authViewModelProvider.notifier);

    return SizedBox(
      height: 30,
      child: InkWell(
        child: Row(
          children: [
            SizedBox(width: width(context) * 0.04,),
            widget.menuItem.leading!, 
            SizedBox(width: width(context) * 0.075,),
            Text(widget.menuItem.titleText!),
          ],
        ),
        onTap: () {
          context.router.pop();
          if (widget.menuItem.titleText == 'Logout') {
            model.signout();
          }
          // widget.menuItem.onTap;
          context.router.push(widget.menuItem.route!);
        },
      ),
    );
    
    // ListTile(
    //   leading: menuItem.leading,
    //   title: Text(menuItem.titleText!),
    //   onTap: () {
    //     context.router.pop();
    //     menuItem.onTap;
    //     context.router.push(menuItem.route!);
    //   }
    // );
  }
}