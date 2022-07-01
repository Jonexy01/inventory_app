import 'package:inventory_app/core/utils/constants.dart';

class PasswordValidator {
  static String? validatePassword(String value) {
    final regExp = RegExp(passwordRegex);
    if (value.isEmpty) {
      return emptyPasswordField;
    }else if (value.length < 8) {
      return passwordLengthError;
    }else if (!regExp.hasMatch(value)) {
      return invalidPassword;
    } else {
      return null;
    }
  }
}

class EmailValidator {
  static String? validateEmail(String value) {
    final regExp = RegExp(emailRegex);
    if (value.isEmpty) {
      return emptyEmailField;
    }else if (!regExp.hasMatch(value)) {
      return invalidEmailField;
    } else {
      return null;
    }
  }
}