import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gadian/services/error_handler.dart';

import '../../models/user_model.dart';

class UserProfile {
  final User? _user = FirebaseAuth.instance.currentUser;
  ExceptionStatus? _status;
  Future<dynamic> getUserInfo() async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/${_user?.uid}');
    UserModel userModel;
    var userdata = {
      'email': _user?.email,
    };
    try {
      DataSnapshot snapshot = await ref.get();
      Map info = snapshot.value as Map;
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

  Future<AuthStatus> sendPasswordResetEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    AuthStatus status;
    try {
      String email = _user?.email ?? '';
      await auth.sendPasswordResetEmail(email: email);
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }
}
