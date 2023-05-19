import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadian/components/custom_floating_action_button.dart';

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
          icon: Icons.add,
          onPressed: () {
            customModalBottomSheet(context);
          },
        )
      ],
    );
  }

  Future<dynamic> customModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            Text(
              'Select contacts to add.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 50,
                itemBuilder: (_, index) => ListTile(
                  leading: Icon(Icons.person_2_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
