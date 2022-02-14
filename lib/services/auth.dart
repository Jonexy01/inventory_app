import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/MyClasses/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create myuser object based on User (FirebaseUser)
  MyUser? converUsertoMyuser(User? user){
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
    //.map((User? user) => converUsertoMyuser(user));
    .map(converUsertoMyuser);
  }

  //sign in anom
  Future mySignInAnon() async {
    try{
      UserCredential userInfo = await _auth.signInAnonymously();
      User? user = userInfo.user;
      return converUsertoMyuser(user);
    } catch(e) {
        return null;
    }
  }

  //sign in with email and password

  //register with email and password

  //sign out
  Future mySignOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {

    }
  }

}