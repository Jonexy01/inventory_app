import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/MyClasses/user_data_collection.dart';

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

  //all userData from snapshot
  List<MyUserData> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyUserData(
        name: doc.get('name') ?? '',
        businessType: doc.get('businessType') ?? '',
        status: doc.get('status') ?? '',
      );
    }).toList();
  }

  //current userdata document from snapshot
  MyUserData _currentUserDataFromSnapshot(QuerySnapshot snapshot) {
    DocumentSnapshot docSnapshot = snapshot.docs[0];
    return MyUserData(
      name: docSnapshot.get('name') ?? '',
      businessType: docSnapshot.get('businessType') ?? '',
      status: docSnapshot.get('status') ?? '',
    );
  }

  //get userData stream
  Stream<List<MyUserData>> get currentUserData {
    return appUser.snapshots()
      .map(_userDataFromSnapshot);
  }

  //get userData document stream
  Stream<MyUserData> get currentUserDocument {
    return appUser.snapshots()
      .map(_currentUserDataFromSnapshot);
  }
}