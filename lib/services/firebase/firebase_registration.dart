import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth firebaseAuth;
  Authentication(this.firebaseAuth);

  //Create account
  Future<void> createAccount(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  //Login to existing account
  Future<void> login({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('We cannot find any account with those credentials');
      } else if (e.code == 'wrong-password') {
        throw Exception('Incorrect password');
      }
    }
  }

  //Logout

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }
}
