// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserRecord _$$_UserRecordFromJson(Map<String, dynamic> json) =>
    _$_UserRecord(
      id: json['id'] as String?,
      businessName: json['businessName'] as String?,
      role: json['role'] as String?,
      name: json['name'] as String?,
      fcmToken: json['fcmToken'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_UserRecordToJson(_$_UserRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessName': instance.businessName,
      'role': instance.role,
      'name': instance.name,
      'fcmToken': instance.fcmToken,
      'email': instance.email,
    };
