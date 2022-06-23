import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/services/local_database/hive_keys.dart';
import 'package:inventory_app/core/services/local_database/local_database.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._reader) : super(LoginState()){
    _authStateChangesSubscription!.cancel();
    _authStateChangesSubscription = authStateChanges.listen((event) { 
      state = state.copyWith(
        user: event,
      );
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription!.cancel();
    super.dispose();
  }

  StreamSubscription<User?>? _authStateChangesSubscription;

  final Reader _reader;

  Stream<User?> get authStateChanges => 
  _reader(firebaseAuthProvider).authStateChanges();

  Future<ServiceResponse> signinWithEmailAndPassword(
      String email, String password) async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      await _reader(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      //await HiveStorage.put(HiveKeys.hasLoggedIn, true);
      return ServiceResponse(successMessage: 'Login successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ServiceResponse(errorMessage: 'Email provided not registered yet');
      } else if (e.code == 'wrong-password') {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ServiceResponse(
            errorMessage: 'Password provided is wrong');
      } else {
        return ServiceResponse(
            errorMessage: 'An unexpected error occured');
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }
}

class LoginState {
  Loader loadStatus;
  User? user;

  LoginState({this.loadStatus = Loader.idle, this.user});

  LoginState copyWith({Loader? loadStatus, User? user}) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      user: user ?? this.user,
    );
  }
}
