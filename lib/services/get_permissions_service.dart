import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider = Provider((ref) => GetPermissionService());

class GetPermissionService {
  Future<dynamic> getContactsPermission() async {
    var status = await Permission.contacts.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.contacts.request();
    }
    return status;
  }
}
