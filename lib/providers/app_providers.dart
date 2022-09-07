import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/crud_firestore/notification_crud.dart';
import 'package:inventory_app/core/services/crud_firestore/product_crud.dart';
import 'package:inventory_app/core/services/crud_firestore/user_data_crud.dart';
import 'package:inventory_app/presentation/authentication/auth_viewmodel.dart';
import 'package:inventory_app/presentation/authentication/secondary_user_approval/approve_secondary_user_viewmodel.dart';
import 'package:inventory_app/presentation/home/homepage/home_page_viewmodel.dart';
import 'package:inventory_app/presentation/notification/notification_viewmodel.dart';
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

final firebaseMessagingProvider =
    Provider<FirebaseMessaging>((ref) => FirebaseMessaging.instance);

final firebaseOnMessagingProvider =
    Provider((ref) => FirebaseMessaging.onMessage);

final firebaseOnMessagingOpenedAppsProvider =
    Provider((ref) => FirebaseMessaging.onMessageOpenedApp);

final productCrudProvider = Provider<ProductCrud>(
  (ref) => ProductCrud(ref.read),
);

final userDataCrudProvider = Provider<UserDataCrud>(
  (ref) => UserDataCrud(ref.read),
);

final notificationCrudProvider =
    Provider<NotificationCrud>((ref) => NotificationCrud(ref.read));

///
///STATENOTIFIERPROVIDERS
///
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
    (ref) => AuthViewModel(ref.read));

final notificationViewModelProvider =
    StateNotifierProvider<NotificationViewModel, NotificationState>(
        (ref) => NotificationViewModel(ref.read));

final secondaryApprovalViewModelProvider =
    StateNotifierProvider<SecondaryApprovalViewModel, SecondaryApprovalState>(
        (ref) => SecondaryApprovalViewModel(ref.read));

final homepageViewModelProvider =
    StateNotifierProvider<HomePageViewModel, HomePageState>(
        (ref) => HomePageViewModel(ref.read));
