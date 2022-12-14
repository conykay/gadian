import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final cloudFireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

//Internet connection status Provider.
final internetChecker = StreamProvider<InternetConnectionStatus>(
    (ref) => InternetConnectionChecker().onStatusChange);
