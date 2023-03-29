import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/models/menu_items_model.dart';
import 'package:gadian/screens/Alerts/alerts_main_page.dart';
import 'package:gadian/screens/Contacts/contacts_main_page.dart';
import 'package:gadian/screens/profile/profile_screen.dart';

final navigatorIndex = StateProvider<int>((ref) => 0);

//Todo:Complete navigation logic.
class MainScreen extends ConsumerWidget {
  MainScreen({Key? key}) : super(key: key);

  final _contactsKey = GlobalKey<NavigatorState>();

  Future<bool> onBackButtonPressed(WidgetRef ref) async {
    bool exitingApp = true;
    var index = ref.watch(navigatorIndex);
    switch (index) {
      case 0:
        //Unimplemented pop logic for the Alerts screen
        exitingApp = false;
        break;
      case 1:
        if (_contactsKey.currentState != null &&
            _contactsKey.currentState!.canPop()) {
          _contactsKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 2:
        //unimplemented pop logic for the Profile Screen
        exitingApp = false;
        break;
      default:
        exitingApp = false;
    }
    return exitingApp ? true : false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int nIndex = ref.watch(navigatorIndex);

    const navigationItems = <BottomMenuItem>[
      BottomMenuItem(iconData: Icons.warning_sharp, label: 'Alerts'),
      BottomMenuItem(iconData: Icons.contacts, label: 'Contacts'),
      BottomMenuItem(iconData: Icons.person, label: 'Profile')
    ];

    var buildBody = <Widget>[
      AlertMainPage(),
      ContactsMainPage(navigatorKey: _contactsKey),
      ProfileScreen()
    ];

    void showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 600),
          margin: EdgeInsets.only(
              bottom: kBottomNavigationBarHeight, right: 2, left: 2),
          content: Text('Tap back button again to exit'),
        ),
      );
    }

    void hideSnackBar() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }

    var oldTime = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final bool isExiting = await onBackButtonPressed(ref);
        if (isExiting) {
          var newTime = DateTime.now();
          int diff = newTime.difference(oldTime).inMilliseconds;
          oldTime = newTime;
          if (diff < 1500) {
            hideSnackBar();
            return isExiting;
          } else {
            showSnackBar();
            return false;
          }
        } else {
          return isExiting;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            navigationItems[nIndex].label,
          ),
        ),
        body: IndexedStack(
          index: nIndex,
          children: buildBody,
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) => ref
              .watch(navigatorIndex.notifier)
              .update((state) => state = index),
          selectedIndex: nIndex,
          destinations: navigationItems
              .map((BottomMenuItem item) => NavigationDestination(
                    icon: Icon(item.iconData),
                    label: item.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
