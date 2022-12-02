import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('You are now in buddy dont die.'),
            ElevatedButton(
              onPressed: () =>
                  ref.watch(authenticationViewModelProvider.notifier).logOut(),
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
