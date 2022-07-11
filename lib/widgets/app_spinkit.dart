import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key, this.color, this.size = 50.0}) : super(key: key);
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: color ?? AppColors.white,
        size: size,
      ),
    );
  }
}