import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/notification_model/notification_model.dart';
import 'package:inventory_app/core/services/firebase_firestore_extension.dart';
import 'package:inventory_app/providers/app_providers.dart';

abstract class NotificationBaseCrud {
  Future<List<NotificationModel>> retrieveAllNotifications({required String userId});
  Future<List<NotificationModel>> retrieveNotificationCategory({required String userId, required String userCategory});
  Future<String> insertNotification({required String userId, required NotificationModel notification});
  Future<void> deleteNotification({required String userId, required String notificationId});
  Future<void> createNotification({required String userId, required NotificationModel notification});
}

class NotificationCrud implements NotificationBaseCrud {
  final Reader _read;

  const NotificationCrud(this._read);

  @override
  Future<List<NotificationModel>> retrieveAllNotifications({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).notificationsRef(userId).get();
      return snap.docs.map((doc) => NotificationModel.fromDocument(doc)).toList();
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> retrieveNotificationCategory({required String userId, required String userCategory}) async {
    try {
      final notificationsSnap = await _read(firebaseFirestoreProvider).notificationsRef(userId).where('userCategory', isEqualTo: userCategory).get();
      return notificationsSnap.docs.map((doc) => NotificationModel.fromDocument(doc)).toList();
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> insertNotification({required String userId, required NotificationModel notification}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .notificationsRef(userId)
          .add(notification.toDocument());
      return docRef.id;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> createNotification({required String userId, required NotificationModel notification}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .notificationsDocumentRef(userId)
          .set(notification.toDocument());
      //return docRef.id;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNotification({required String userId, required String notificationId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .notificationsRef(userId)
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

}