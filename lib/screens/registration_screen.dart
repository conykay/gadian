import 'package:flutter/material.dart';
import 'package:gadian/screens/pages/signup_page.dart';

import 'pages/login_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _regController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _regController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SignUpPage(pageController: _regController),
            LoginPage(pageController: _regController),
          ],
        ),
      ),
    );
  }
}
