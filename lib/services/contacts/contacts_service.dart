import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/contact_model.dart';
import 'package:gadian/services/get_permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';

final contactsServiceProvider = Provider((ref) {
  GetPermissionService getPermissionService = ref.read(permissionProvider);
  return RetrieveContactsService(getPermissionService);
});

class RetrieveContactsService {
  GetPermissionService getPermissionService;

  RetrieveContactsService(this.getPermissionService);

  Future<List<ContactModel>> getContactsFromDevice() async {
    List<Contact> retrievedContacts = [];
    List<ContactModel> parsedContacts = [];
    var status = await getPermissionService.getContactsPermission();
    if (status == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts(withThumbnails: false);
      retrievedContacts = contacts;
    }
    if (retrievedContacts.isNotEmpty) {
      var index = 0;
      for (var contact in retrievedContacts) {
        Item item = contact.phones!.first;
        parsedContacts.add(ContactModel(
          id: index.toString(),
          name: contact.displayName!,
          phoneNumber: item.value!,
          selected: false,
        ));
        index++;
      }
    }
    return parsedContacts;
  }
}
