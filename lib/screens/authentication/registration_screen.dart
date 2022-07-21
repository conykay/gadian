import 'package:flutter/material.dart';

import 'pages/forgotPassword_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _regController = PageController();
  var _currentIndex = 0;
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        } else {
          await _regController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
          return false;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: PageView(
            onPageChanged: (index) => setState(() {
              _currentIndex = index;
            }),
            controller: _regController,
            children: [
              SignUpPage(pageController: _regController),
              LoginPage(pageController: _regController),
              ForgotPasswordPage(pageController: _regController)
            ],
          ),
        ),
      ),
    );
  }
}
