import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';

class SignupViewModel extends StateNotifier<SignupState> {
  SignupViewModel(this._reader) : super(SignupState());

  final Reader _reader;

  Future<ServiceResponse> sendVerificationEmail() async {
    try {
      final user = _reader(firebaseAuthProvider).currentUser;
      await user!.sendEmailVerification();
      return ServiceResponse(
        successMessage: 'Verification email sent successfully',
      );
    } catch (e) {
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
          state.copyWith(email: userInfo.user!.email, uid: userInfo.user!.uid);
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
}

class SignupState {
  Loader? loadStatus;
  String? email;
  String? uid;

  SignupState({
    this.loadStatus,
    this.email,
    this.uid,
  });

  SignupState copyWith({Loader? loadStatus, String? email, String, uid}) {
    return SignupState(
      loadStatus: loadStatus ?? this.loadStatus,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }
}
