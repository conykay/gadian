//TODO:implement viewmodel class and methods

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/contacts/contacts_service.dart';

final contactsViewModelProvider = Provider((ref) {
  var retrieveContacts = ref.watch(contactsServiceProvider);
  return ContactsViewModel(retrieveContacts);
});

class ContactsViewModel extends ChangeNotifier {
  List<Contact> _contacts = [];

  RetrieveContactsService retrieveContacts;

  ContactsViewModel(this.retrieveContacts);

  List<Contact> get contacts => _contacts;

  Future loadContactsFromDevice() async {
    _contacts = await retrieveContacts.getContactsFromDevice();
    notifyListeners();
  }
}
