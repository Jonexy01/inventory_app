import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference usersRef() => collection('users');

  DocumentReference usersDocumentRef(uid) => collection('users').doc(uid);

  CollectionReference secondaryUsersRef(String userId) =>
      collection('users').doc(userId).collection('secondaryUsers');

  DocumentReference secondaryUsersDocumentRef(String uid, String secondaryUid) =>
      collection('users').doc(uid).collection('secondaryUsers').doc(secondaryUid);

  CollectionReference userProductsRef(String userId) =>
      collection('users').doc(userId).collection('products');

  DocumentReference userProductsDocumentRef(String userId) =>
      collection('users').doc(userId).collection('products').doc();

  CollectionReference notificationsRef(String userId) =>
      collection('users').doc(userId).collection('notifications');

  DocumentReference notificationsDocumentRef(String userId) =>
      collection('users').doc(userId).collection('notifications').doc();
}
