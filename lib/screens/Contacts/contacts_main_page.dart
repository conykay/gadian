import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/screens/Contacts/pages/contact_list_page.dart';
import 'package:gadian/screens/Contacts/pages/create_contact_group_page.dart';

class ContactsMainPage extends ConsumerStatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const ContactsMainPage({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ContactsMainPageState();
}

class _ContactsMainPageState extends ConsumerState<ContactsMainPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (context) => const CreateContactsGroup();
            break;
          case '/createContactGroup':
            builder = (context) => const CreateContactsGroup();
            break;
          default:
            builder = (context) => const ContactsList();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
