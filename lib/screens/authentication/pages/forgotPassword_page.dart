import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/components/registrationPageTitle.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';
import 'package:gadian/services/error_handler.dart';

final showLoadingForgotPassword = StateProvider<bool>((ref) => false);

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  AuthStatus? _status;

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);
    return Column(
      children: [
        kBuildPageTitle(
          context,
          'Forgot password!',
          'Enter your email to receive a password reset link.',
          Icons.lock_reset,
        ),
        const Divider(),
        _buildForgotPasswordForm(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: FilledButton(
            onPressed: () => _handleForgotPassword(scaffold),
            child: ref.watch(showLoadingForgotPassword)
                ? CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5))
                : const Text('Send Reset email'),
          ),
        ),
      ],
    );
  }

  Future<void> _handleForgotPassword(ScaffoldMessengerState scaffold) async {
    if (_formKey.currentState!.validate()) {
      _toggle;
      await ref
          .watch(authenticationViewModelProvider.notifier)
          .resetPassword(email: _email)
          .then((value) => _status = value);
      if (_status != AuthStatus.successful) {
        _toggle;
        final error = AuthExceptionHandler.generateErrorMessage(_status);
        _showBanner(
            scaffold, error, Colors.redAccent, Icons.highlight_remove_outlined);
      } else {
        _toggle;
        String message = 'Email sent successfully check your inbox.';
        _showBanner(scaffold, message, Colors.green, Icons.email_outlined);
        widget.pageController.previousPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      }
    }
  }

  void _toggle() =>
      ref.watch(showLoadingForgotPassword.notifier).update((state) => !state);

  void _showBanner(ScaffoldMessengerState scaffold, String message, Color color,
      IconData icon) {
    scaffold.showMaterialBanner(infoMaterialBanner(
      content: message,
      icon: icon,
      color: color,
      onPressed: () => scaffold.hideCurrentMaterialBanner(),
    ));
  }

  Widget _buildForgotPasswordForm() {
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
                  onChanged: (value) => _email = value,
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
            ],
          ),
        ),
      ),
    );
  }
}
