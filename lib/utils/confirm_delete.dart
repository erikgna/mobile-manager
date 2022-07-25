import 'package:flutter/material.dart';

AlertDialog? callDeleteDialog(
    BuildContext context, void Function() deleteFunction) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm delete"),
        content: const Text("If you confirm, it will be permanently deleted"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close')),
          TextButton(onPressed: deleteFunction, child: const Text('Confirm'))
        ],
      );
    },
  );
  return null;
}
