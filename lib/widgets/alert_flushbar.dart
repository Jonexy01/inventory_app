import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class AlertFlushbar {
  static void showNotification({
    required BuildContext context,
    bool isWarning = false,
    String message = '',
  }) {
    Flushbar(
      maxWidth: MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: isWarning ? AppColors.red : AppColors.purple,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      showProgressIndicator: false,
      boxShadows: [
        BoxShadow(
          color: AppColors.purple.withOpacity(0.5),
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
      icon: isWarning
          ? Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.transparent,
                  shape: BoxShape.circle),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
      message: message,
      messageColor: AppColors.white,
      messageSize: 18,
    ).show(context);
  }
}
