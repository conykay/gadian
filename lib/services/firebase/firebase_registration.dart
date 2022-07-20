import 'package:firebase_auth/firebase_auth.dart';

import '../error_handler.dart';

class Authentication {
  final FirebaseAuth firebaseAuth;
  Authentication(this.firebaseAuth);
  AuthStatus? _status;

  //Create account
  Future<AuthStatus> createAccount(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status!;
  }

  //Login to existing account
  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status!;
  }

  //Reset password
  Future<AuthStatus> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status!;
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
