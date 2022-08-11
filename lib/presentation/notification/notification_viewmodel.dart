import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inventory_app/core/models/notification_model/notification_model.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
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
}

class NotificationState {
  NotificationState({
    this.loadStatus,
    this.notifications,
  });

  Loader? loadStatus;
  List<NotificationModel>? notifications;

  NotificationState copyWith(
      {Loader? loadStatus, List<NotificationModel>? notifications}) {
    return NotificationState(
      loadStatus: loadStatus ?? this.loadStatus,
      notifications: notifications ?? this.notifications,
    );
  }
}
