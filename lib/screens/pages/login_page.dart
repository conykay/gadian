import 'package:flutter/material.dart';
import 'package:gadian/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  final _formKey = GlobalKey<FormState>();
  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("The form is valid "),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account?',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => widget.pageController.previousPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn),
                    child: Text(
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
          onPressed: () {},
          child: Text('Forgot password ?'),
        )
      ],
    );
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
