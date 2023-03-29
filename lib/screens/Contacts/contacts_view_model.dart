//TODO:implement viewmodel class and methods

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/contacts/contacts_service.dart';

import '../../models/contact_model.dart';

final contactsViewModelProvider =
    StateNotifierProvider<ContactsViewModel, List<ContactModel>>((ref) {
  var retrieveContacts = ref.read(contactsServiceProvider);
  return ContactsViewModel(retrieveContacts);
});

class ContactsViewModel extends StateNotifier<List<ContactModel>> {
  RetrieveContactsService retrieveContacts;

  ContactsViewModel(this.retrieveContacts) : super([]);

  Future loadContactsFromDevice() async {
    state = await retrieveContacts.getContactsFromDevice();
  }

  void selected(String itemId) {
    state = [
      for (final item in state)
        if (item.id == itemId)
          item.copyWith(selected: !item.selected)
        else
          item,
    ];
  }
}
