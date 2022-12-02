import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/project_providers.dart';

import '../error_handler.dart';

final authProvider = Provider((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return Authentication(firebaseAuth);
});

class Authentication {
  final FirebaseAuth firebaseAuth;
  final db = FirebaseDatabase.instance;
  Authentication(this.firebaseAuth);
  AuthStatus? _authStatus;
  ExceptionStatus? _exceptionStatus;
  //Create account
  Future<dynamic> createAccount({required UserModel userModel}) async {
    bool authException = false;
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password)
          .then((userCred) async {
        final user = userCred.user;
        final uid = user?.uid;
        final DatabaseReference ref = db.ref('users/$uid');

        //TODO: Place bellow logic in database service.
        try {
          await ref.set({
            'name': userModel.name,
            'phoneNumber': userModel.phoneNumber,
            'contacts': userModel.contacts,
          });
          await user?.updateDisplayName(userModel.name);
        } on FirebaseException catch (e) {
          authException = true;
          await user?.delete();
          _exceptionStatus = ExceptionHandler.handleException(e);
        }
      });
      _authStatus = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _authStatus = AuthExceptionHandler.handleAuthException(e);
    }
    return authException ? _exceptionStatus! : _authStatus!;
  }

  //Login to existing account
  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _authStatus = AuthExceptionHandler.handleAuthException(e);
    }
    return _authStatus!;
  }

  //Reset password
  Future<AuthStatus> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      _authStatus = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _authStatus = AuthExceptionHandler.handleAuthException(e);
    }
    return _authStatus!;
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
