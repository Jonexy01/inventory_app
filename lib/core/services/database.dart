import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/user_data_collection.dart';

enum SubUserResult {errorEncountered, notManagerEmail}

class DatabaseService {

  final String? uid;

  ///Instance of DatabaseService. The app level data access class
  DatabaseService({this.uid});

  ///userData collection reference from firestore
  final CollectionReference appUser = FirebaseFirestore.instance.collection('userData');

  ///update or create userData collection document in firestore
  Future updateUserData(String name, String email,) async {
    return await appUser.doc(uid).set({
      "name": name,
      "email": email,
    });
  }

  ///update the name and role of userData collection document in firestore
  Future updateUserDataNameRole({required String name, String? businessName, required String status}) async {
    if (businessName == null) {
      return await appUser.doc(uid).update({"name": name, "status": status});
    } else {
      return await appUser.doc(uid).update({"name": name, "status": status, "businessName": businessName});
    }
    
  }

  ///all userData from snapshot
  List<MyUserData> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyUserData(
        name: (doc.data()! as dynamic)['name'] ?? '',
        businessType: (doc.data() as dynamic)['businessName'] ?? '',
        status: (doc.data() as dynamic)['status'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
      );
    }).toList();
  }

  ///Current userdata document from snapshot.
  MyUserData _userDataDocumentFromSnapshot(DocumentSnapshot snapshot,) {

    return MyUserData(
        name: (snapshot.data()! as dynamic)['name'] ?? '',
        businessType: (snapshot.data()! as dynamic)['businessName'] ?? '',
        status: (snapshot.data()! as dynamic)['status'] ?? '',
        email: (snapshot.data()! as dynamic)['email'] ?? '',
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
    .map(_userDataDocumentFromSnapshot);
  }

  ///update or create a user subcollection under another user collection
  Future createSubuserUnderUser (String name, String managerEmail, String status) async {
    SubUserResult subUserResult;
    try {
      QuerySnapshot managerCollection = await appUser.where('email', isEqualTo: managerEmail).get();
      DocumentSnapshot managerDoc = managerCollection.docs[0];
      String managerUID = managerDoc.id;
      String _role = managerDoc['status'];
      if (_role == 'Manager') {
        appUser.doc(managerUID).collection('staff').doc(uid).set({
          "name": name,
        });
      }
      else {
        subUserResult = SubUserResult.notManagerEmail;
        return subUserResult;
      }
    } catch (e) {
      subUserResult = SubUserResult.errorEncountered;
      return subUserResult;
    } 
  }
}