import 'package:inventory_app/core/models/notification_model/notification_model.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:riverpod/riverpod.dart';

class SecondaryApprovalViewModel extends StateNotifier<SecondaryApprovalState> {
  SecondaryApprovalViewModel(this.reader) : super(SecondaryApprovalState());

  final Reader reader;

  void loadNotification(NotificationModel notification) {
    state = state.copyWith(
      notification: notification,
    );
  }
}

class SecondaryApprovalState {
  SecondaryApprovalState({this.notification, this.loadStatus,});

  NotificationModel? notification;
  Loader? loadStatus;

  SecondaryApprovalState copyWith({Loader? loadStatus, NotificationModel? notification,}) {
    return SecondaryApprovalState(
      loadStatus: loadStatus ?? this.loadStatus,
      notification: notification ?? this.notification,
    );
  }
}