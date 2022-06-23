import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/providers/app_providers.dart';



abstract class BaseAuthService {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously ();
  Future signInWithEmailAndPassword ();
  Future signUpWithEmailAndPassword ();
  User? getCurrentUser ();
  Future<void> signOut();
}

class AuthServices implements BaseAuthService {

  AuthServices (this._read);

  final Reader _read;

  @override
  Stream<User?> get authStateChanges => 
  _read(firebaseAuthProvider).authStateChanges();
  //throw UnimplementedError();

  @override
  Future<void> signInAnonymously () {
    throw UnimplementedError();
  }

  @override
  Future signInWithEmailAndPassword () {
    throw UnimplementedError();
  }

  @override
  Future signUpWithEmailAndPassword () {
    throw UnimplementedError();
  }

  @override
  User? getCurrentUser () {
    throw UnimplementedError();
  }

  @override 
  Future<void> signOut() {
    throw UnimplementedError();
  }

}