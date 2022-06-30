import 'package:flutter/material.dart';
import 'package:passwords_client/models/form_field_info.dart';

class DefaultForm extends StatefulWidget {
  final List<FormFieldInfo> formFieldInfos;
  final GlobalKey<FormState> formKey;
  const DefaultForm(
      {Key? key, required this.formFieldInfos, required this.formKey})
      : super(key: key);

  @override
  State<DefaultForm> createState() => _DefaultFormState();
}

class _DefaultFormState extends State<DefaultForm> {
  @override
  Widget build(BuildContext context) {
    final List forms = [];

    for (FormFieldInfo formField in widget.formFieldInfos) {
      forms.add(TextFormField(
        controller: formField.textController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          if (value.length < 6) return 'At least 6 characters';
          return null;
        },
        decoration: InputDecoration(hintText: formField.hint),
        obscureText: formField.isPassword,
      ));
    }

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          ...forms,
        ],
      ),
    );
  }
}
