import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/info_material_banner.dart';
import 'package:gadian/components/registration_page_title.dart';
import 'package:gadian/constants.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';
import 'package:loading_indicator/loading_indicator.dart';

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

  final emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);

    ref.listen<AsyncValue<bool>>(
      authenticationViewModelProvider,
      (_, state) => state.whenOrNull(error: (e, st) {
        _showBanner(scaffold, e.toString(), Colors.redAccent,
            Icons.highlight_remove_outlined);
      }, data: (value) {
        if (value == true) {
          String message = 'Email sent successfully check your inbox.';
          _showBanner(scaffold, message, Colors.green, Icons.email_outlined);
          widget.pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        }
      }),
    );

    final passwordRecoveryState = ref.watch(authenticationViewModelProvider);
    final isLoading = passwordRecoveryState is AsyncLoading<bool>;
    return isLoading
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
                'Forgot password!',
                'Enter your email to receive a password reset link.',
                Icons.lock_reset,
              ),
              const Divider(),
              _buildForgotPasswordForm(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: FilledButton(
                  onPressed: () => _handleForgotPassword(scaffold),
                  child: const Text('Send Reset email'),
                ),
              ),
            ],
          );
  }

  Future<void> _handleForgotPassword(ScaffoldMessengerState scaffold) async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(authenticationViewModelProvider.notifier)
          .resetPassword(email: _email);
    }
  }

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
                  controller: emailController,
                  onChanged: (value) => _email = emailController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}
