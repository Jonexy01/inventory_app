import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';

void handleError({
  required e,
  required BuildContext context,
}) {
  if (e.runtimeType == String) {
    AlertFlushbar.showNotification(
      message: e,
      isWarning: true,
      context: context,
    );
  } else {
    AlertFlushbar.showNotification(
      message: e.message,
      isWarning: true,
      context: context,
    );
  }
}

void showConnectionError({required BuildContext context}) {
  AlertFlushbar.showNotification(
      message: enableConnection, isWarning: true, context: context);
}
