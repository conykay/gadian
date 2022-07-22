import 'package:flutter/material.dart';
import 'package:gadian/services/firebase/firebase_registration.dart';

class Authprovider extends Authentication with ChangeNotifier {
  Authprovider(super.firebaseAuth);
}
