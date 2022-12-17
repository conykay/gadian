import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

class CreateContactsGroup extends ConsumerStatefulWidget {
  const CreateContactsGroup({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateContactsGroupState();
}

class _CreateContactsGroupState extends ConsumerState<CreateContactsGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Create contact group',
                style: kHeadlineText.copyWith(
                  fontSize: 25,
                  color: const Color(0xff850000),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
