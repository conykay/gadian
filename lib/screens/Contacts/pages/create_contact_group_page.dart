import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/screens/Contacts/contacts_view_model.dart';

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
    ref.watch(contactsViewModelProvider).loadContactsFromDevice();
    List<Contact> contacts = ref.watch(contactsViewModelProvider).contacts;
    return Column(
      children: [
        _buildTitle(context),
        contacts.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  bool? state = false;
                  return CheckboxListTile(
                    tileColor: const Color(0xfffff6c3),
                    value: state,
                    onChanged: (value) => setState(() {
                      state = value;
                    }),
                  );
                },
              ),
      ],
    );
  }

  Row _buildTitle(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff11468f),
          ),
        ),
        Expanded(
          child: Text(
            'New contact group',
            textAlign: TextAlign.start,
            style: kHeadlineText.copyWith(
              fontSize: 22,
              color: const Color(0xff11468f),
            ),
          ),
        )
      ],
    );
  }
}
