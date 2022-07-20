import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/infoMaterialBanner.dart';
import '../../components/registrationPageTitle.dart';
import '../../constants.dart';
import '../../methods/providers/authentication_provider.dart';
import '../../services/error_handler.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _loading = false;
  AuthStatus? _status;

  @override
  Widget build(BuildContext context) {
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
          child: ElevatedButton(
            onPressed: () async {
              await _handleForgotPassword(context);
            },
            child: _loading
                ? CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5))
                : const Text('Send Reset email'),
          ),
        ),
      ],
    );
  }

  Future<void> _handleForgotPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await Provider.of<Authprovider>(context, listen: false)
          .resetPassword(email: _email)
          .then((value) => _status = value);
      if (_status == AuthStatus.successful) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showMaterialBanner(infoMaterialBanner(
          content: 'Email sent successfully. Check your inbox.',
          icon: Icons.email_outlined,
          color: Colors.green,
          onPressed: () =>
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
        ));
        widget.pageController.previousPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else {
        setState(() => _loading = false);
        final error = AuthExceptionHandler.generateErrorMessage(_status);
        ScaffoldMessenger.of(context).showMaterialBanner(
          infoMaterialBanner(
            content: error,
            icon: Icons.highlight_remove_outlined,
            color: Colors.redAccent,
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          ),
        );
      }
    }
  }

  _buildForgotPasswordForm() {
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
            ],
          ),
        ),
      ),
    );
  }
}
