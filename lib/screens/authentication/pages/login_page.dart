import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);

    return ref.watch(loadingLogin)
        ? const Center(
            child: LoadingIndicator(
              indicatorType: Indicator.ballScaleMultiple,
              colors: [
                Colors.red,
                Colors.lightBlueAccent,
              ],
            ),
          )
        : Column(
            children: [
              kBuildPageTitle(
                context,
                'Welcome back!',
                'Login to continue',
                Icons.key,
              ),
              const Divider(),
              _buildLoginForm(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Column(
                  children: [
                    FilledButton(
                      onPressed: () => _handleLogin(scaffold),
                      child: const Text('Login'),
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
                  controller: emailController,
                  textInputAction: TextInputAction.next,
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
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: ref.watch(showPasswordLogin),
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
                        ref.watch(showPasswordLogin)
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
