import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_record_model.freezed.dart';
part 'user_record_model.g.dart';

@Freezed()
abstract class UserRecord implements _$UserRecord {
  const UserRecord._();

  factory UserRecord({
    String? id,
    String? businessName,
    String? role,
    String? name,
    String? fcmToken,
  }) = _UserRecord;

  factory UserRecord.fromJson(Map<String, dynamic> json) =>
      _$UserRecordFromJson(json);

  factory UserRecord.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserRecord.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
