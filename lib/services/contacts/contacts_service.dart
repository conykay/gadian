import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/services/get_permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';

final contactsServiceProvider = Provider((ref) {
  GetPermissionService getPermissionService = ref.watch(permissionProvider);
  return RetrieveContactsService(getPermissionService);
});

class RetrieveContactsService {
  GetPermissionService getPermissionService;

  RetrieveContactsService(this.getPermissionService);

  Future<List<Contact>> getContactsFromDevice() async {
    List<Contact> retrievedContacts = [];
    var status = await getPermissionService.getContactsPermission();
    if (status == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts(withThumbnails: false);
      retrievedContacts = contacts;
    }
    return retrievedContacts;
  }
}
