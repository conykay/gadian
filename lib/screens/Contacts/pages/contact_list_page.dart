import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsList extends ConsumerStatefulWidget {
  const ContactsList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ContactsListState();
}

class _ContactsListState extends ConsumerState<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
