import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/services/firebase/firebase_registration.dart';

final authenticationViewModelProvider =
    StateNotifierProvider<AuthenticationViewModel, AsyncValue<bool>>((ref) {
  final auth = ref.watch(authProvider);
  return AuthenticationViewModel(authentication: auth);
});

class AuthenticationViewModel extends StateNotifier<AsyncValue<bool>> {
  AuthenticationViewModel({required this.authentication})
      : super(const AsyncValue.data(false));
  final Authentication authentication;

  //create account
  Future<void> createAccount(UserModel userModel) async {
    try {
      state = const AsyncValue.loading();
      await authentication.createAccount(userModel: userModel);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      state = const AsyncValue.data(false);
    }
  }

  //login
  Future<void> login({required String email, required String password}) async {
    try {
      state = const AsyncValue.loading();
      await authentication.login(email: email, password: password);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      state = const AsyncValue.data(false);
    }
  }

  //reset password
  Future<void> resetPassword({required String email}) async {
    try {
      state = const AsyncValue.loading();
      await authentication.resetPassword(email: email);
      state = const AsyncValue.data(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  //logout
  Future<void> logOut() => authentication.logout();
}
//todo: Use async notifier instead.
