import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/contact_model.dart';
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
  void initState() {
    super.initState();
    ref.read(contactsViewModelProvider.notifier).loadContactsFromDevice();
  }

  @override
  Widget build(BuildContext context) {
    List<ContactModel> contacts = ref.watch(contactsViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        contacts.isEmpty
            ? FloatingActionButton(
                onPressed: () => ref
                    .watch(contactsViewModelProvider.notifier)
                    .loadContactsFromDevice())
            : Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    ContactModel item = contacts[index];
                    return Card(
                      child: CheckboxListTile(
                        value: item.selected,
                        title: Text(item.name),
                        subtitle: Text(item.phoneNumber),
                        onChanged: (value) => ref
                            .read(contactsViewModelProvider.notifier)
                            .selected(item.id),
                      ),
                    );
                  },
                ),
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
          child: Text('Select new group members',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge),
        )
      ],
    );
  }
}

//TODO:Find out how to diaplay the phone numbers better
