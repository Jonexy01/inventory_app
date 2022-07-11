import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/presentation/authentication/auth_viewmodel.dart';
//import 'package:inventory_app/presentation/authentication/signup/signup_viewmodel.dart';

//This file stores all providers that will be used throughout the app.
//This includes all PROVIDERS and STATENOTIFIERPROVIDERS
//PROVIDERS will be used to register services for proper DEPENDENCY INJECTION
//STATENOTIFIERPROVIDERS will be used to register viewmodels

//SERVICE PROVIDERS
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

///
///STATENOTIFIERPROVIDERS
///
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>(
        (ref) => AuthViewModel(ref.read));

// final signupViewModelProvider =
//     StateNotifierProvider<SignupViewModel, SignupState>(
//         (ref) => SignupViewModel(ref.read));
