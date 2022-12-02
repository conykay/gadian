import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:gadian/services/firebase/firebase_registration.dart';

final authenticationViewModelProvider =
    StateNotifierProvider<AuthenticationViewModel, dynamic>((ref) {
  final auth = ref.watch(authProvider);
  return AuthenticationViewModel(auth);
});

class AuthenticationViewModel extends StateNotifier<dynamic> {
  AuthenticationViewModel(this.authentication) : super(dynamic);
  Authentication authentication;

  //create account
  Future<dynamic> createAccount(UserModel userModel) =>
      authentication.createAccount(userModel: userModel);
  //login
  Future<AuthStatus> login({required String email, required String password}) =>
      authentication.login(email: email, password: password);

  //reset password
  Future<AuthStatus> resetPassword({required String email}) =>
      authentication.resetPassword(email: email);

  //logout
  Future<void> logOut() => authentication.logout();
}
