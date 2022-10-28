// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationModel _$$_NotificationModelFromJson(Map<String, dynamic> json) =>
    _$_NotificationModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      notificationType: json['notificationType'] as String?,
      primaryId: json['primaryId'] as String?,
      userNotifying: json['userNotifying'] as String?,
      userIdNotifying: json['userIdNotifying'] as String?,
      userCategory: json['userCategory'] as String? ?? 'all',
    );

Map<String, dynamic> _$$_NotificationModelToJson(
        _$_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'notificationType': instance.notificationType,
      'primaryId': instance.primaryId,
      'userNotifying': instance.userNotifying,
      'userIdNotifying': instance.userIdNotifying,
      'userCategory': instance.userCategory,
    };
