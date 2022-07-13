import 'package:flutter/material.dart';

import '../../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: kHeadlineText,
        ),
        Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => widget.pageController.previousPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeIn,
              ),
              child: Text('Sign up'),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text('Forgot password ?'),
        )
      ],
    );
  }
}
