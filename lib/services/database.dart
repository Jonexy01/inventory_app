import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference appUser = FirebaseFirestore.instance.collection('userData');

  Future updateUserData(String name, String businessType, String status) async {
    return await appUser.doc(uid).set({
      name: name,
      businessType: businessType,
      status: status,
    });
  }

}