import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inventory_app/core/models/notification_model/notification_model.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/models/user_record/user_record_model.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

class NotificationViewModel extends StateNotifier<NotificationState> {
  NotificationViewModel(this.reader) : super(NotificationState());

  final Reader reader;

  Future<ServiceResponse> fetchAllNotifications() async {
    state = state.copyWith(loadStatus: Loader.loading);
    try {
      final cResult = await Connectivity().checkConnectivity();
      if (cResult != ConnectivityResult.none) {
        final userId = reader(authViewModelProvider).user!.uid;
        final notifications = await reader(notificationCrudProvider)
            .retrieveAllNotifications(userId: userId);
        state = state.copyWith(
          notifications: notifications,
          loadStatus: Loader.loaded,
        );
        return ServiceResponse(
            successMessage: 'All notifications retrieved successfully');
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

  void loadNotification(NotificationModel notification) {
    state = state.copyWith(
      notification: notification,
    );
  }

  Future<ServiceResponse> removeNotification(
      {required String notificationId}) async {
    state = state.copyWith(dialogueLoader: Loader.loading);
    if (!(await checkNetwork())) {
      return ServiceResponse(errorMessage: enableConnection);
    }
    final userId = reader(authViewModelProvider).user!.uid;
    try {
      await reader(notificationCrudProvider)
          .deleteNotification(userId: userId, notificationId: notificationId);
      state = state.copyWith(notification: null, dialogueLoader: Loader.loaded,);
      return ServiceResponse(successMessage: 'Notification deleted successful');
    } on FirebaseException catch (e) {
      state = state.copyWith(dialogueLoader: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(dialogueLoader: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> addSecondaryUser({
    required UserRecord userRecord,
    required String primaryUid,
  }) async {
    state = state.copyWith(dialogueLoader: Loader.loading);
    if (!(await checkNetwork())) {
      return ServiceResponse(errorMessage: enableConnection);
    }
    try {
      await reader(userDataCrudProvider)
          .createSecondaryUser(userRecord: userRecord, primaryUid: primaryUid);
      await reader(userDataCrudProvider).updateSecondaryUserApproval(uid: userRecord.id!);
      state = state.copyWith(dialogueLoader: Loader.loaded);
      return ServiceResponse(
          successMessage: 'Secondary user added successfuly');
    } on FirebaseException catch (e) {
      state = state.copyWith(dialogueLoader: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(dialogueLoader: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> fetchSecondaryUser({required String secondaryUserId}) async {
    state = state.copyWith(dialogueLoader: Loader.loading);
    if (!(await checkNetwork()))
      {return ServiceResponse(errorMessage: enableConnection);}
    try{
      final response = await reader(userDataCrudProvider).retrieveUserRecord(uid: secondaryUserId);
      state = state.copyWith(secondaryUserRecord: response, dialogueLoader: Loader.loaded,);
      return ServiceResponse(successMessage: 'Secondary user fetched succssefuly');
    } on FirebaseException catch (e) {
      state = state.copyWith(dialogueLoader: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(dialogueLoader: Loader.error);
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

class NotificationState {
  NotificationState({
    this.loadStatus,
    this.dialogueLoader,
    this.notifications,
    this.notification,
    this.secondaryUserRecord,
  });

  Loader? loadStatus;
  Loader? dialogueLoader;
  List<NotificationModel>? notifications;
  NotificationModel? notification;
  UserRecord? secondaryUserRecord;

  NotificationState copyWith({
    Loader? loadStatus,
    Loader? dialogueLoader,
    List<NotificationModel>? notifications,
    NotificationModel? notification,
    UserRecord? secondaryUserRecord,
  }) {
    return NotificationState(
      loadStatus: loadStatus ?? this.loadStatus,
      dialogueLoader: dialogueLoader ?? this.dialogueLoader,
      notifications: notifications ?? this.notifications,
      notification: notification ?? this.notification,
      secondaryUserRecord: secondaryUserRecord ?? this.secondaryUserRecord,
    );
  }
}
