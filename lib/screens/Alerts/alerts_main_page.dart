import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertMainPage extends ConsumerStatefulWidget {
  const AlertMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AlertMainPageState();
}

class _AlertMainPageState extends ConsumerState<AlertMainPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
