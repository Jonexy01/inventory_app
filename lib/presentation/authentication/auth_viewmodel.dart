import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
// import 'package:inventory_app/core/services/local_database/hive_keys.dart';
// import 'package:inventory_app/core/services/local_database/local_database.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this._reader) : super(AuthState()){
    //_authStateChangesSubscription!.cancel();
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
      UserCredential userInfo = await _reader(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      //await HiveStorage.put(HiveKeys.hasLoggedIn, true);
      state = state.copyWith(user: userInfo.user, loadStatus: Loader.loaded);
      return ServiceResponse(successMessage: 'Login successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        state = state.copyWith(
          loadStatus: Loader.error
        );
        return ServiceResponse(errorMessage: 'Email provided not registered yet');
      } else if (e.code == 'wrong-password') {
        state = state.copyWith(
          loadStatus: Loader.error
        );
        return ServiceResponse(
            errorMessage: 'Password provided is wrong');
      } else {
        state = state.copyWith(
          loadStatus: Loader.error
        );
        return ServiceResponse(
            errorMessage: 'An unexpected error occured');
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error
      );
      rethrow;
    }
  }

  Future<ServiceResponse> resetPassword(String email) async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      await _reader(firebaseAuthProvider).sendPasswordResetEmail(email: email);
      state = state.copyWith(loadStatus: Loader.loaded);
      return ServiceResponse(successMessage: 'Reset email sent successfuly');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: 'Email provided not registered');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: e.code);
      }
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> sendVerificationEmail() async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      final user = _reader(firebaseAuthProvider).currentUser;
      await user!.sendEmailVerification();
      state = state.copyWith(loadStatus: Loader.loaded);
      return ServiceResponse(
        successMessage: 'Verification email sent successfuly',
      );
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> signupWithEmailPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(loadStatus: Loader.loading);

    try {
      UserCredential userInfo = await _reader(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      state =
          state.copyWith(user: userInfo.user, loadStatus: Loader.loaded);
      //await userInfo.user!.sendEmailVerification();
      return ServiceResponse(successMessage: 'Sign up successful');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      if (e.code == 'email-already-in-use') {
        return ServiceResponse(errorMessage: 'Email Already in use');
      } else if (e.code == 'invalid-email') {
        return ServiceResponse(errorMessage: 'Email provided is invalid');
      } else {
        return ServiceResponse(error: e);
      }
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> signout() async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      await _reader(firebaseAuthProvider).signOut();
      state = state.copyWith(loadStatus: Loader.loaded);
      return ServiceResponse(successMessage: 'Signout successful');
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error
      );
      rethrow;
    }
  }
}

class AuthState {
  Loader loadStatus;
  User? user;

  AuthState({this.loadStatus = Loader.idle, this.user});

  AuthState copyWith({Loader? loadStatus, User? user}) {
    return AuthState(
      loadStatus: loadStatus ?? this.loadStatus,
      user: user ?? this.user,
    );
  }
}
