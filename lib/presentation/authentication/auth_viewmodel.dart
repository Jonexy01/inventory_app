import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/core/models/notification_model/notification_model.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/models/user_record/user_record_model.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this._reader) : super(AuthState()) {
    //_authStateChangesSubscription!.cancel();
    // _authStateChangesSubscription = authStateChanges.listen((event) {
    //   state = state.copyWith(
    //     user: event,
    //   );
    // });
  }

  @override
  void dispose() {
    //_authStateChangesSubscription!.cancel();
    super.dispose();
  }

  //StreamSubscription<User?>? _authStateChangesSubscription;

  final Reader _reader;

  Stream<User?> get authStateChanges =>
      _reader(firebaseAuthProvider).authStateChanges();

  Future<ServiceResponse> signinWithEmailAndPassword(
      String email, String password) async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      UserCredential userInfo = await _reader(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      final _userRecord = await _reader(userDataCrudProvider)
          .retrieveUserRecord(uid: userInfo.user!.uid);
      //await HiveStorage.put(HiveKeys.hasLoggedIn, true);
      state = state.copyWith(
          user: userInfo.user,
          loadStatus: Loader.loaded,
          userRecord: _userRecord);
      return ServiceResponse(successMessage: 'Login successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(
            errorMessage: 'Email provided not registered yet');
      } else if (e.code == 'wrong-password') {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: 'Password provided is wrong');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: e.code);
      }
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> resetPassword(String email) async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        await _reader(firebaseAuthProvider)
            .sendPasswordResetEmail(email: email);
        state = state.copyWith(loadStatus: Loader.loaded);
        return ServiceResponse(successMessage: 'Reset email sent successfuly');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
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
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        final user = _reader(firebaseAuthProvider).currentUser;
        await user!.sendEmailVerification();
        state = state.copyWith(loadStatus: Loader.loaded);
        return ServiceResponse(
          successMessage: 'Verification email sent successfuly',
        );
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future checkEmailVerified({bool isFirstLoad = true}) async {
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        if (!isFirstLoad) {
          await _reader(firebaseAuthProvider).currentUser!.reload();
        }
        final _isEmailVerified =
            _reader(firebaseAuthProvider).currentUser!.emailVerified;
        state = state.copyWith(isEmailVerified: _isEmailVerified);
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
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
      final _userRecord =
          UserRecord(id: userInfo.user!.uid, email: userInfo.user!.email);
      await _reader(userDataCrudProvider)
          .createUserRecord(userRecord: _userRecord);
      //HiveStorage.put(HiveKeys.isRoleSelected, false);
      state = state.copyWith(
          user: userInfo.user,
          loadStatus: Loader.loaded,
          userRecord: _userRecord);
      await userInfo.user!.sendEmailVerification();
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
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> signout() async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        await _reader(firebaseAuthProvider).signOut();
        state = state.copyWith(loadStatus: Loader.loaded, user: null);
        return ServiceResponse(successMessage: 'Signout successful');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> updateUserDisplayName(String name) async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        await _reader(firebaseAuthProvider)
            .currentUser!
            .updateDisplayName(name);
        state = state.copyWith(loadStatus: Loader.loaded);
        return ServiceResponse(successMessage: 'Name updated successfuly');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  void fetchCurrrentUser() {
    final currentUser = _reader(firebaseAuthProvider).currentUser;
    if (currentUser != null) {
      state = state.copyWith(
        user: currentUser,
      );
    }
  }

  Future<ServiceResponse> fetchUserRecord() async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        final userInfo = _reader(firebaseAuthProvider).currentUser;
        final UserRecord? _userRecord = await _reader(userDataCrudProvider)
            .retrieveUserRecord(uid: userInfo!.uid);
        state = state.copyWith(
          userRecord: _userRecord,
          loadStatus: Loader.loaded,
          user: userInfo,
        );
        return ServiceResponse(
            successMessage: 'User record fetched successfuly');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> updateUserProfile({
    required String role,
    required String userId,
    String businessName = '',
    String? name,
    required String email,
  }) async {
    state = state.copyWith(loadStatus: Loader.loading);
    UserRecord userRecord = UserRecord(
        id: userId,
        role: role,
        businessName: businessName,
        name: name,
        email: email,
        primaryUserId:
            role == 'primary' ? userId : state.primaryUserRecord!.id);
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        await _reader(userDataCrudProvider)
            .updateUserRecord(userRecord: userRecord);
        state =
            state.copyWith(loadStatus: Loader.loaded, userRecord: userRecord);
        return ServiceResponse(successMessage: 'Role updated successfuly');
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> notifyPrimaryUser(
      {required NotificationModel notification}) async {
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        await _reader(notificationCrudProvider).createNotification(
            userId: notification.primaryId!, notification: notification);
        return ServiceResponse(
            successMessage: 'Notification created successfuly');
      } else {
        //state = state.copyWith(loadStatus: Loader.error);
        return ServiceResponse(errorMessage: enableConnection);
      }
    } on FirebaseException catch (e) {
      //state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      //state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> fetchPrimaryUser({required String email}) async {
    if (!(await checkNetwork()))
      {return ServiceResponse(errorMessage: enableConnection);}
    try {
      final response = await _reader(userDataCrudProvider)
          .retrieveUserRecordByEmail(email: email);
      if (response.role == 'primary') {
        state = state.copyWith(primaryUserRecord: response);
        return ServiceResponse(
            successMessage: 'Primary user fetched successfuly');
      } else {
        return ServiceResponse(errorMessage: 'Email provided is not for a primary user');
      }
    } on FirebaseException catch (e) {
      //state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      if (e.runtimeType == RangeError) {
        return ServiceResponse(
            errorMessage: 'Provided primary user email is not on record');
      }
      //state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> fetchSecondaryUser({required String secondaryUserId}) async {
    if (!(await checkNetwork()))
      {return ServiceResponse(errorMessage: enableConnection);}
    try{
      final response = await _reader(userDataCrudProvider).retrieveUserRecord(uid: secondaryUserId);
      state = state.copyWith(secondaryUserRecord: response,);
      return ServiceResponse(successMessage: 'Secondary user fetched succssefuly');
    } on FirebaseException catch (e) {
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      // if (e.runtimeType == RangeError) {
      //   return ServiceResponse(
      //       errorMessage: 'Provided primary user email is not on record');
      // }
      rethrow;
    }
  }

  Future<bool> checkNetwork() async {
    final cResult = await Connectivity().checkConnectivity();
    if (cResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}

class AuthState {
  Loader loadStatus;
  User? user;
  UserRecord? userRecord;
  bool isEmailVerified;
  UserRecord? primaryUserRecord;
  UserRecord? secondaryUserRecord;
  bool approved;

  AuthState({
    this.loadStatus = Loader.idle,
    this.user,
    this.userRecord,
    this.isEmailVerified = false,
    this.primaryUserRecord,
    this.secondaryUserRecord,
    this.approved = false,
  });

  AuthState copyWith({
    Loader? loadStatus,
    User? user,
    UserRecord? userRecord,
    bool? isEmailVerified,
    UserRecord? primaryUserRecord,
    UserRecord? secondaryUserRecord,
    bool? approved,
  }) {
    return AuthState(
      loadStatus: loadStatus ?? this.loadStatus,
      user: user ?? this.user,
      userRecord: userRecord ?? this.userRecord,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      primaryUserRecord: primaryUserRecord ?? this.primaryUserRecord,
      secondaryUserRecord: secondaryUserRecord ?? this.secondaryUserRecord,
      approved: approved ?? this.approved,
    );
  }
}
