import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference usersRef() => collection('users');

  DocumentReference usersDocumentRef(uid) => collection('users').doc(uid);

  CollectionReference userProductsRef(String userId) =>
      collection('users').doc(userId).collection('products');
}
