import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anom
  Future mySignInAnon() async {
    try{
      UserCredential userInfo = await _auth.signInAnonymously();
      User? user = userInfo.user;
      return user;
    } catch(e) {
        return null;
    }
  }

  //sign in with email and password

  //register with email and password

  //sign out

}