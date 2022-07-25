import 'dart:async';

import 'package:flutter/material.dart';

MaterialBanner infoMaterialBanner({
  required String content,
  required IconData icon,
  required Color color,
  required void Function() onPressed,
}) {
  List<Widget> actions = [
    TextButton(
      onPressed: onPressed,
      child: const Text(
        'Dismiss',
        style: TextStyle(color: Colors.white),
      ),
    )
  ];
  final timer = Timer(const Duration(seconds: 5), onPressed);
  return MaterialBanner(
    leading: Icon(
      icon,
      color: Colors.white.withOpacity(0.8),
    ),
    content: Text(
      content,
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
      ),
    ),
    actions: actions,
    backgroundColor: color,
    onVisible: () => timer,
  );
}
