import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';
import 'package:gadian/services/error_handler.dart';

final showPasswordLogin = StateProvider<bool>((ref) => false);
final loadingLogin = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthStatus? _status;
  void _toggle() {
    ref.watch(showPasswordLogin.notifier).update((state) => !state);
  }

  var userdata = {};
  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);
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
                  await _handleLogin(scaffold);
                },
                child: ref.watch(loadingLogin)
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

  Future<void> _handleLogin(ScaffoldMessengerState scaffold) async {
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print(userdata);
      }
      ref.watch(loadingLogin.notifier).update((state) => !state);
      await ref
          .watch(authenticationViewModelProvider.notifier)
          .login(email: userdata['email'], password: userdata['password'])
          .then((value) => _status = value);
      _handleStatus(scaffold);
    }
  }

  void _handleStatus(ScaffoldMessengerState scaffold) {
    if (_status != AuthStatus.successful) {
      ref.watch(loadingLogin.notifier).update((state) => !state);
      final error = AuthExceptionHandler.generateErrorMessage(_status);
      _showBanner(scaffold, error);
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
                  obscureText: ref.watch(showPasswordLogin),
                  onChanged: (value) =>
                      userdata = {...userdata, 'password': value},
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field cannot be empty.'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        ref.watch(showPasswordLogin)
                            ? Icons.visibility_off
                            : Icons.visibility,
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
