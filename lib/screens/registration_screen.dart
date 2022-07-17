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
  var _currentIndex = 0;
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
        body: SafeArea(
          child: PageView(
            onPageChanged: (index) => setState(() {
              _currentIndex = index;
            }),
            controller: _regController,
            children: [
              SignUpPage(pageController: _regController),
              LoginPage(pageController: _regController),
            ],
          ),
        ),
      ),
    );
  }
}
