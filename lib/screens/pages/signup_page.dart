import 'package:flutter/material.dart';
import 'package:gadian/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Create account',
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(),
              ),
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
              child: Text('Sign up'),
            ),
            TextButton(
              onPressed: () => widget.pageController.nextPage(
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn),
              child: Text('Login'),
            ),
          ],
        ),
      ],
    );
  }
}
