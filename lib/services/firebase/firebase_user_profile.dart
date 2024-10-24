import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/project_providers.dart';
import 'package:gadian/services/firebase/firestore_paths.dart';

import '../../models/user_model.dart';


final userProfileProvider = Provider<UserProfile>((ref) {
  final authstate = ref.watch(authStateChangesProvider);
  return UserProfile(authstate.value);
});

class UserProfile {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late UserModel userModel;
  final User? user;

  UserProfile(this.user);

  Stream<UserModel> getUserInfo() async* {
    final currentProfileRef = _db.doc(FireStorePath.userProfile(user!.uid));
    Stream<DocumentSnapshot> snapshot = currentProfileRef.snapshots();
    final usermodel = snapshot.map((snpsht){
      return UserModel.fromJson(snpsht.data() as Map<String, dynamic>);
    });
    yield* usermodel;
  }

  // Future<AuthStatus> sendPasswordResetEmail() async {
  //   AuthStatus status;
  //   try {
  //     String email = _user?.email ?? '';
  //     await _auth.sendPasswordResetEmail(email: email);
  //     status = AuthStatus.successful;
  //   } on FirebaseAuthException catch (e) {
  //     status = AuthExceptionHandler.handleAuthException(e);
  //   }
  //   return status;
  // }
}
