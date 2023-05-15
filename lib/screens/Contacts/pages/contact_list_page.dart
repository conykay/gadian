import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsList extends ConsumerStatefulWidget {
  const ContactsList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ContactsListState();
}

class _ContactsListState extends ConsumerState<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Column(),
        CustomFloatingActionButton(
          buttonColor: const Color(0xff11468f),
          icon: Icons.add,
          onPressed: () => Navigator.pushNamed(context, '/createContactGroup'),
        )
      ],
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    required this.buttonColor,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Function() onPressed;
  final Color buttonColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
