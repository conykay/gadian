import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';

import '../../../models/user_model.dart';
import '../../../services/error_handler.dart';

final showPasswordSignUp = StateProvider<bool>((ref) => false);
final loadingSignUp = StateProvider<bool>((ref) => false);

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  Map userdata = {};
  UserModel? userModel;
  AuthStatus? _authStatus;
  ExceptionStatus? _exceptionStatus;
  void _toggle() {
    ref.watch(showPasswordSignUp.notifier).update((state) => state = !state);
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          kBuildPageTitle(
            context,
            'Sign up',
            'Create account to continue',
            Icons.person,
          ),
          const Divider(),
          _buildSignUpForm(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Column(
              children: [
                FilledButton(
                  onPressed: () => _handleSignup(scaffold),
                  child: ref.watch(loadingSignUp)
                      ? CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.5))
                      : const Text('Sign up'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ?',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () => widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //sign up form
  Padding _buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: userdata['name'],
                onChanged: (value) => userdata = {...userdata, 'name': value},
                validator: (value) => value == null || value.isEmpty
                    ? 'This field cannot be empty.'
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: userdata['email'],
                onChanged: (value) => userdata = {...userdata, 'email': value},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  } else if (kIsValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: userdata['phoneNumber'],
                onChanged: (value) =>
                    userdata = {...userdata, 'phoneNumber': value},
                validator: (value) => value == null || value.isEmpty
                    ? 'This field cannot be empty.'
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                obscureText: ref.watch(showPasswordSignUp),
                onChanged: (value) =>
                    userdata = {...userdata, 'password': value},
                validator: (value) => value == null || value.isEmpty
                    ? 'This field cannot be empty.'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      ref.watch(showPasswordSignUp)
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _toggle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // sign up logic
  Future<void> _handleSignup(ScaffoldMessengerState scaffold) async {
    final loadingNotifier = ref.watch(loadingSignUp.notifier);
    if (_formKey.currentState!.validate()) {
      loadingNotifier.update((state) => !state);

      var data = jsonEncode(userdata);
      UserModel userinfo = UserModel.fromJson(jsonDecode(data));
      if (kDebugMode) {
        print(userinfo);
      }
      await ref
          .watch(authenticationViewModelProvider.notifier)
          .createAccount(userinfo)
          .then((value) => value.runtimeType == AuthStatus
              ? _authStatus = value
              : _exceptionStatus = value);
      if (_authStatus != AuthStatus.successful) {
        loadingNotifier.update((state) => !state);
        String error;
        _exceptionStatus != null
            ? error = ExceptionHandler.generateErrorMessage(_exceptionStatus)
            : error = AuthExceptionHandler.generateErrorMessage(_authStatus);

        _showBanner(scaffold, error);
      }
    }
  }

  void _showBanner(ScaffoldMessengerState scaffold, String error) {
    scaffold.showMaterialBanner(
      infoMaterialBanner(
        content: error,
        icon: Icons.highlight_remove_outlined,
        color: Colors.redAccent,
        onPressed: () => scaffold.hideCurrentMaterialBanner(),
      ),
    );
  }
}
