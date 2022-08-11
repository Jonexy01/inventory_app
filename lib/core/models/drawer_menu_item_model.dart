import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem {
  final Icon? leading;
  final String? titleText;
  // final VoidCallback? onTap;
  final PageRouteInfo<dynamic>? route;

  DrawerMenuItem({this.leading, this.titleText, this.route});
}