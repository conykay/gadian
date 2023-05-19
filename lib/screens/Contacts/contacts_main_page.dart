import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/screens/Contacts/pages/contact_list_page.dart';
import 'package:gadian/screens/Contacts/pages/create_contact_group_page.dart';

class ContactsMainPage extends ConsumerStatefulWidget {
  const ContactsMainPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ContactsMainPageState();
}

class _ContactsMainPageState extends ConsumerState<ContactsMainPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Contacts'),
                Tab(text: 'Groups'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ContactsList(),
                  CreateContactsGroup(),
                ],
              ),
            ),
          ],
        ));
  }
}
