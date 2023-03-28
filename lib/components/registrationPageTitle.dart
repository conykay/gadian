// Registration Page Title Widget
import 'package:flutter/material.dart';

Container kBuildPageTitle(
    BuildContext context, String title, String info, IconData icon) {
  return Container(
    decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.05)),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              icon,
              size: 50,
              color: Colors.redAccent,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  info,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
