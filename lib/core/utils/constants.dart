import 'package:flutter/material.dart';

const String emptyPasswordField = 'Password field cannot be empty';
const String passwordLengthError = 'Password length must be greater than 8';
const String invalidPassword = 'Password must meet all requirements';
const String emptyTextField = 'Field cannot be empty!';
const String emptyEmailField = 'Email field cannot be empty!';
const String invalidEmailField =
    "Email provided isn't valid.Try another email address";
const String enableConnection = 'Please enable internet connection';

//REGEX
const String passwordRegex =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
const String emailRegex = '[a-zA-Z0-9+._%-+]{1,256}'
    '\\@'
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}'
    '('
    '\\.'
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}'
    ')+';

//MediaQuery Width
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//MediaQuery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}