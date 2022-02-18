import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/MyClasses/routes.dart';
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
  Future mySigninWithEmailPassword (String email, String password) async {
    try {
      UserCredential userInfo = await _auth.signInWithEmailAndPassword(email: email, password: password,);
      User? user = userInfo.user;
      return converUsertoMyuser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future mySignUpWithEmailPassword (String email, String password) async {
    try {
      UserCredential userInfo = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
      User? user = userInfo.user;
      return converUsertoMyuser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future mySignOut(BuildContext context, String route) async {
    try {
      await _auth.signOut();
      return Navigator.pushReplacementNamed(context, route);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}