import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/methods/providers/authentication_provider.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  AuthStatus? _status;
  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  var userdata = {};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kBuildPageTitle(
          context,
          'Welcome back!',
          'Access your account to continue.',
          Icons.key,
        ),
        const Divider(),
        _buildLoginForm(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _handleLogin(context);
                },
                child: _loading
                    ? CircularProgressIndicator(
                        color: Colors.white.withOpacity(0.5))
                    : const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            widget.pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: const Text('Forgot password ?'),
        )
      ],
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    var scaffold = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print(userdata);
      }
      setState(() => _loading = true);
      await Provider.of<Authprovider>(context, listen: false)
          .login(email: userdata['email'], password: userdata['password'])
          .then((value) => _status = value);
      if (_status != AuthStatus.successful) {
        setState(() => _loading = false);
        final error = AuthExceptionHandler.generateErrorMessage(_status);
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

  Padding _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) =>
                      userdata = {...userdata, 'email': value},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be empty";
                    } else if (kIsValidEmail(value)) {
                      return "Please enter a valid email address";
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
                  obscureText: _showPassword,
                  onChanged: (value) =>
                      userdata = {...userdata, 'password': value},
                  validator: (value) => value == null || value.isEmpty
                      ? "This field cannot be empty."
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
      ),
    );
  }
}
