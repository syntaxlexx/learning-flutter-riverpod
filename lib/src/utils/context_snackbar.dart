import 'package:flutter/material.dart';

extension ContextWarningUI on BuildContext {
  void showSnackBar(BuildContext context,
          {String message = 'Message', IconData icon = Icons.warning}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                // color: Theme.of(context).snackBarTheme.actionTextColor,
                color: Colors.grey.shade100,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(message),
            ],
          ),
        ),
      );
}
