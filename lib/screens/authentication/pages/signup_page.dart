import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';
import 'package:loading_indicator/loading_indicator.dart';

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

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);
    return ref.watch(loadingSignUp)
        ? const Center(
            child: LoadingIndicator(
              indicatorType: Indicator.ballScaleMultiple,
              colors: [
                Colors.red,
                Colors.lightBlueAccent,
              ],
            ),
          )
        : SingleChildScrollView(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Column(
                    children: [
                      FilledButton(
                        onPressed: () => _handleSignup(scaffold),
                        child: const Text('Sign up'),
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
                controller: usernameController,
                onChanged: (value) =>
                    userdata = {...userdata, 'name': usernameController.text},
                validator: (value) => usernameController.text.isEmpty
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    userdata = {...userdata, 'email': emailController.text},
                validator: (value) {
                  if (emailController.text.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  if (kIsValidEmail(emailController.text)) {
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
                onChanged: (value) => userdata = {
                  ...userdata,
                  'phoneNumber': phoneNumberController.text
                },
                validator: (value) => phoneNumberController.text.isEmpty
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
                onChanged: (value) => userdata = {
                  ...userdata,
                  'password': passwordController.text
                },
                validator: (value) => passwordController.text.isEmpty
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
