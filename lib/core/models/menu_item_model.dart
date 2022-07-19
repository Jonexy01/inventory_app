import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final Icon? leading;
  final String? titleText;
  final VoidCallback? onTap;
  final PageRouteInfo<dynamic>? route;

  MenuItem({this.leading, this.titleText, this.onTap, this.route});
}