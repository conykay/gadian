import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:gadian/services/firebase/firestore_paths.dart';

import '../../models/user_model.dart';

class UserProfile {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  ExceptionStatus? _status;

  Future<dynamic> getUserInfo() async {
    final currentProfileRef =
        _db.doc(FireStorePath.userProfile(_user?.uid as String));
    UserModel userModel;
    var userdata = {
      'email': _user?.email,
    };
    try {
      DocumentSnapshot snapshot = await currentProfileRef.get();
      Map info = snapshot.data() as Map<String, dynamic>;
      userdata = {...userdata, ...info};
      var data = jsonEncode(userdata);
      userModel = UserModel.fromJson(jsonDecode(data));
      _status = ExceptionStatus.successful;
      return userModel;
    } on FirebaseException catch (e) {
      _status = ExceptionHandler.handleException(e);
    }
    return _status;
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
