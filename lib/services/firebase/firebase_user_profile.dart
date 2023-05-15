import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:gadian/services/firebase/firestore_paths.dart';

import '../../models/user_model.dart';

final userProfileProvider = Provider<UserProfile>((_) => UserProfile());

class UserProfile {
  final User? _user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late UserModel userModel;

  Future<UserModel> getUserInfo() async {
    final currentProfileRef = _db.doc(
      FireStorePath.userProfile(_user?.uid as String),
    );
    var userdata = {
      'email': _user?.email,
    };
    try {
      DocumentSnapshot snapshot = await currentProfileRef.get();
      var info = snapshot.data() as Map<String, dynamic>;
      userdata = {...userdata, ...info};
      var data = jsonEncode(userdata);
      userModel = UserModel.fromJson(jsonDecode(data));
      debugPrint('This was run.');
      return userModel;
    } on FirebaseException catch (e) {
      throw ExceptionHandler.generateErrorMessage(
          ExceptionHandler.handleException(e));
    }
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
