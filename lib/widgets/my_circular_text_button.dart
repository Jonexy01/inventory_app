import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/widgets/app_spinkit.dart';

class MyCircularTextButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final bool isLoading;
  
  const MyCircularTextButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = AppColors.purple,
    this.textColor = AppColors.white,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                vertical: 20, 
                horizontal: 40,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(color)
          ),
          onPressed: isLoading ? null : press, 
          child: isLoading ? const AppLoading(size: 20) : Text(
            text,
            style: TextStyle(
              letterSpacing: 5,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}