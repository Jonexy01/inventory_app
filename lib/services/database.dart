import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/MyClasses/user_data_collection.dart';

class DatabaseService {

  final String? uid;

  ///Instance of DatabaseService. The app level data access class
  DatabaseService({this.uid});

  ///userData collection reference from firestore
  final CollectionReference appUser = FirebaseFirestore.instance.collection('userData');

  ///update or create userData collection document in firestore
  Future updateUserData(String name, String businessType, String status) async {
    return await appUser.doc(uid).set({
      name: name,
      businessType: businessType,
      status: status,
    });
  }

  ///all userData from snapshot
  List<MyUserData> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyUserData(
        name: (doc.data()! as dynamic)['name'] ?? '',
        businessType: (doc.data() as dynamic)['businessType'] ?? '',
        status: (doc.data() as dynamic)['status'] ?? '',
      );
    }).toList();
  }

  ///Current userdata document from snapshot.
  MyUserData _currentUserDataFromSnapshot(DocumentSnapshot snapshot,) {

    return MyUserData(
        name: (snapshot.data()! as dynamic)['name'] ?? '',
        businessType: (snapshot.data()! as dynamic)['businessType'] ?? '',
        status: (snapshot.data()! as dynamic)['status'] ?? '',
    );
    
  }

  ///get userData stream
  Stream<List<MyUserData>> get currentUserData {
    return appUser.snapshots()
      .map(_userDataFromSnapshot);
  }

  ///get userData document stream
  Stream<MyUserData> get currentUserDocument {
    return appUser.doc(uid).snapshots()
    .map(_currentUserDataFromSnapshot);
  }
}