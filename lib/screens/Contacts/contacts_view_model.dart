import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/contacts/contacts_service.dart';

import '../../models/contact_model.dart';

typedef ContactListState = AsyncValue<List<ContactModel>>;

final contactsViewModelProvider =
    StateNotifierProvider<ContactsViewModel, ContactListState>((ref) {
  var retrieveContacts = ref.read(contactsServiceProvider);
  return ContactsViewModel(retrieveContacts);
});

class ContactsViewModel extends StateNotifier<ContactListState> {
  RetrieveContactsService retrieveContacts;

  ContactsViewModel(this.retrieveContacts) : super(const AsyncData([]));

  Future loadContactsFromDevice() async {
    try {
      state = const AsyncLoading();
      state = AsyncData(await retrieveContacts.getContactsFromDevice());
    } catch (e, stackTrace) {
      AsyncError(e, stackTrace);
    }
  }

  void selected(String itemId) {
    // state = [
    //   for (final item in state)
    //     if (item.id == itemId)
    //       item.copyWith(selected: !item.selected)
    //     else
    //       item,
    // ];
  }
}
