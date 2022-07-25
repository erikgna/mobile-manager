import 'package:flutter/material.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/utils/confirm_delete.dart';

class PasswordWidget extends StatefulWidget {
  final void Function() changeFunction;
  final void Function() deleteFunction;
  final Password pass;
  const PasswordWidget({
    Key? key,
    required this.changeFunction,
    required this.deleteFunction,
    required this.pass,
  }) : super(key: key);

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.pass.contentName!),
      subtitle: Text(widget.pass.password!),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: widget.changeFunction, icon: const Icon(Icons.edit)),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => callDeleteDialog(context, widget.deleteFunction))
        ],
      ),
    );
  }
}
