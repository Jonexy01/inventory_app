import 'package:firebase_auth/firebase_auth.dart';

class ServiceResponse {
  final String successMessage;
  final String errorMessage;
  final String? responseMessage;
  final FirebaseAuthException? error;

  ServiceResponse({
    this.successMessage = '',
    this.errorMessage = 'An error occurred',
    this.responseMessage,
    this.error
  });
}
