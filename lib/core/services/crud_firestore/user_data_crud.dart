import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/user_record/user_record_model.dart';
import 'package:inventory_app/core/services/firebase_firestore_extension.dart';
import 'package:inventory_app/providers/app_providers.dart';

abstract class UserDataBaseCrud {
  Future<void> createUserRecord({required UserRecord userRecord});
  Future<void> updateUserRecord({required UserRecord userRecord});
  Future<UserRecord> retrieveUserRecord({required String uid});
}

class UserDataCrud implements UserDataBaseCrud {

  final Reader _read;

  const UserDataCrud(this._read);

  @override
  Future<void> createUserRecord({required UserRecord userRecord}) async {
    try {
      await _read(firebaseFirestoreProvider).usersRef().doc(userRecord.id).set({
        'name': 'unasigned',
        //'role': 'unasigned',
      });
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserRecord({required UserRecord userRecord}) async {
    Map<String, dynamic> formData = userRecord.toDocument();
    try {
      await _read(firebaseFirestoreProvider).usersRef().doc(userRecord.id).update(formData);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserRecord> retrieveUserRecord({required String uid}) async {
    try {
      final userDoc = await _read(firebaseFirestoreProvider).usersDocumentRef(uid).get();
      final userRecord = UserRecord.fromDocument(userDoc);
      return userRecord;
    } on FirebaseException catch (_) {
      rethrow;
    }
  } 
}