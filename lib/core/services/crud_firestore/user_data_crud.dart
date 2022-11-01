import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/user_record/user_record_model.dart';
import 'package:inventory_app/core/services/firebase_firestore_extension.dart';
import 'package:inventory_app/providers/app_providers.dart';

abstract class UserDataBaseCrud {
  Future<void> createUserRecord({required UserRecord userRecord});
  Future<void> updateUserRecord({required UserRecord userRecord});
  Future<void> updateFcmToken({required String uid, required String fcmToken});
  Future<UserRecord> retrieveUserRecord({required String uid});
  Future<UserRecord> retrieveUserRecordByEmail({required String email});
  Future<void> createSecondaryUser(
      {required UserRecord userRecord, required String primaryUid});
  Future<void> updateSecondaryUserApproval({required String uid});
  Future<List<UserRecord>> retrieveSecondaryUserRecords({required String primaryUid});
}

class UserDataCrud implements UserDataBaseCrud {
  final Reader _read;

  const UserDataCrud(this._read);

  @override
  Future<void> createUserRecord({required UserRecord userRecord}) async {
    try {
      await _read(firebaseFirestoreProvider).usersDocumentRef(userRecord.id)
          // usersRef().doc(userRecord.id)
          .set({
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
      await _read(firebaseFirestoreProvider)
          .usersRef()
          .doc(userRecord.id)
          .update(formData);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateFcmToken({required String uid, required String fcmToken}) async {
    try {
      await _read(firebaseFirestoreProvider).usersDocumentRef(uid).update({"fcmToken": fcmToken});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserRecord> retrieveUserRecord({required String uid}) async {
    try {
      final userDoc =
          await _read(firebaseFirestoreProvider).usersDocumentRef(uid).get();
      final userRecord = UserRecord.fromDocument(userDoc);
      return userRecord;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserRecord> retrieveUserRecordByEmail({required String email}) async {
    try {
      final userDocs = await _read(firebaseFirestoreProvider)
          .usersRef()
          .where("email", isEqualTo: email)
          .get()
          .then((value) => value.docs.toList());
      final userDoc = userDocs[0];
      final userRecord = UserRecord.fromDocument(userDoc);
      return userRecord;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> createSecondaryUser(
      {required UserRecord userRecord, required String primaryUid}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .secondaryUsersDocumentRef(primaryUid, userRecord.id!)
          .set(userRecord.toDocument());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSecondaryUserApproval({required String uid}) async {
    try {
      await _read(firebaseFirestoreProvider).usersDocumentRef(uid).update({"approved": true});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserRecord>> retrieveSecondaryUserRecords({required String primaryUid}) async {
    try {
      final response = await _read(firebaseFirestoreProvider).secondaryUsersRef(primaryUid).get();
      return response.docs.map((doc) => UserRecord.fromDocument(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
