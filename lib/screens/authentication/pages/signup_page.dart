import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/models/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/error_handler.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _showPassword = true;
  final _formKey = GlobalKey<FormState>();
  var userdata = {};
  bool _loading = false;
  AuthStatus? _authStatus;
  ExceptionStatus? _exceptionStatus;
  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ElevatedButton(
                  onPressed: () async {
                    await _handleSignup(context);
                  },
                  child: _loading
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

  Future<void> _handleSignup(BuildContext context) async {
    var scaffold = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print(userdata);
      }
      setState(() => _loading = true);
      await Provider.of<Authprovider>(context, listen: false)
          .createAccount(
              email: userdata['email'], password: userdata['password'])
          .then((value) => value.runtimeType == AuthStatus
              ? _authStatus = value
              : _exceptionStatus = value);
      if (_authStatus != AuthStatus.successful) {
        setState(() => _loading = false);
        String error;
        if (_exceptionStatus != null) {
          error = ExceptionHandler.generateErrorMessage(_exceptionStatus);
        } else {
          error = AuthExceptionHandler.generateErrorMessage(_authStatus);
        }
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
  }

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
                obscureText: _showPassword,
                onChanged: (value) =>
                    userdata = {...userdata, 'password': value},
                validator: (value) => value == null || value.isEmpty
                    ? 'This field cannot be empty.'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
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
}