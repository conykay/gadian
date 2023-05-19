import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/custom_floating_action_button.dart';

class CreateContactsGroup extends ConsumerStatefulWidget {
  const CreateContactsGroup({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateContactsGroupState();
}

class _CreateContactsGroupState extends ConsumerState<CreateContactsGroup> {
  @override
  void initState() {
    super.initState();
  }

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

//TODO:Find out how to diaplay the phone numbers better
