import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME USER'),
      ),
      body: Center(
        child: Text('You are now in buddy dont die.'),
      ),
    );
  }
}
