import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

class HomePageViewModel extends StateNotifier<HomePageState> {
  HomePageViewModel(this._reader) : super(HomePageState());

  final Reader _reader;

  Future<ServiceResponse> getToken() async {
    try {
      final fcmToken = await _reader(firebaseMessagingProvider).getToken();
      state = state.copyWith(
        fcmToken: fcmToken,
      );
      return ServiceResponse(successMessage: 'FCM Token fetched successfuly');
    } on FirebaseException catch (e) {
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      return ServiceResponse(errorMessage: 'Something went wrong');
    }
  }

  void requestNotificationPermissions() {
    _reader(firebaseMessagingProvider).requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );
  }

  void configureMessaging({VoidCallback? navigateToNotifications}) {
    _reader(firebaseMessagingProvider)
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
    );
    _reader(firebaseOnMessagingProvider).listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null) {
        // flutterLocalNotificationsPlugin.show(
        //     notification.hashCode,
        //     notification.title,
        //     notification.body,
        //     NotificationDetails(
        //       android: AndroidNotificationDetails(
        //         channel.id,
        //         channel.name,
        //         channel.description,
        //         // TODO add a proper drawable resource to android, for now using
        //         //      one that already exists in example app.
        //         icon: 'launch_background',
        //       ),
        //     ));
      }
    });
    _reader(firebaseOnMessagingOpenedAppsProvider).listen((
      RemoteMessage message,
    ) {
      navigateToNotifications;
    });
  }
}

class HomePageState {
  HomePageState({
    this.loadStatus,
    this.fcmToken,
  });

  Loader? loadStatus;
  String? fcmToken;

  HomePageState copyWith({
    Loader? loadStatus,
    String? fcmToken,
  }) {
    return HomePageState(
      loadStatus: loadStatus ?? this.loadStatus,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
