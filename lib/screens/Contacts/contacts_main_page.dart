import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsMainPage extends ConsumerStatefulWidget {
  const ContactsMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ContactsMainPageState();
}

class _ContactsMainPageState extends ConsumerState<ContactsMainPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(),
      );
  }
}
