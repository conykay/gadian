import 'package:flutter/material.dart';
import 'package:gadian/models/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('You are now in buddy dont die.'),
            ElevatedButton(
              onPressed: () => context.read<Authprovider>().logout(),
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
