import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/menu_items_model.dart';
import 'package:gadian/screens/Alerts/alerts_main_page.dart';
import 'package:gadian/screens/Contacts/contacts_main_page.dart';
import 'package:gadian/screens/profile/profile_screen.dart';

final navigatorIndex = StateProvider<int>((ref) => 0);

//Todo:Complete navigation logic.
class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int nIndex = ref.watch(navigatorIndex);
    const navigationItems = <BottomMenuItem>[
      BottomMenuItem(iconData: Icons.warning_sharp, label: 'Alerts'),
      BottomMenuItem(iconData: Icons.contacts, label: 'Contacts'),
      BottomMenuItem(iconData: Icons.person, label: 'Profile')
    ];
    const buildBody = <Widget>[
      AlertMainPage(),
      ContactsMainPage(),
      ProfileScreen()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(navigationItems[nIndex].label),
      ),
      body: IndexedStack(
        index: nIndex,
        children: buildBody,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (index) =>
            ref.watch(navigatorIndex.notifier).update((state) => state = index),
        currentIndex: nIndex,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        items: navigationItems
            .map((BottomMenuItem item) => BottomNavigationBarItem(
                  icon: Icon(item.iconData),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}
