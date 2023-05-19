import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/custom_floating_action_button.dart';

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
    return Stack(
      children: [
        const Column(),
        CustomFloatingActionButton(
          icon: Icons.add,
          onPressed: () {
            throw UnimplementedError('No function yet, just like you.');
          },
        )
      ],
    );
  }
}
