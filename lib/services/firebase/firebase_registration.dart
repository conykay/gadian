
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/project_providers.dart';
import 'package:gadian/services/firebase/firestore_paths.dart';

import '../error_handler.dart';

final authProvider = Provider((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return Authentication(firebaseAuth: firebaseAuth);
});

class Authentication {
  final FirebaseAuth firebaseAuth;
  final db = FirebaseFirestore.instance;
  Authentication({required this.firebaseAuth});

  //Error handlers
  String _generateAuthError(e) => AuthExceptionHandler.generateErrorMessage(
      AuthExceptionHandler.handleAuthException(e));
  String _generateError(e) => ExceptionHandler.generateErrorMessage(
      ExceptionHandler.handleException(e));

  //Create account
  Future<void> createAccount({required UserModel userModel}) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password)
          .then((userCred) async {
        await editUserProfile(userCred, userModel);
      });
    } on FirebaseAuthException catch (e) {
      throw _generateAuthError(e);
    } on FirebaseException catch (e) {
      throw _generateError(e);
    }
  }

  Future<void> editUserProfile(
      UserCredential userCred, UserModel userModel) async {
    final user = userCred.user;
    final uid = user?.uid;
    final ref = db.doc(FireStorePath.userProfile(uid as String));

    try {
      await ref.set({
        'name': userModel.name,
        'phoneNumber': userModel.phoneNumber,
      });
      await user?.updateDisplayName(userModel.name);
    } catch (_) {
      await user?.delete();
      rethrow;
    }
  }

  //Login to existing account
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _generateAuthError(e);
    } on FirebaseException catch (e) {
      throw _generateError(e);
    }
  }

  //Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _generateAuthError(e);
    } on FirebaseException catch (e) {
      throw _generateError(e);
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
