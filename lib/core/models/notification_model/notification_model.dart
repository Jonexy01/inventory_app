import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@Freezed()
abstract class NotificationModel implements _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    String? id,
    String? title,
    String? body,
    String? notificationType,
    String? userNotifying,
    @Default('all') String userCategory,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromDocument(DocumentSnapshot doc) {
    if (doc.data() == null) {return const NotificationModel();}
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
