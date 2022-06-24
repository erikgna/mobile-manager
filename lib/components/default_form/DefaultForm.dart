import 'package:flutter/material.dart';
import 'package:passwords_client/models/form_field_info.dart';

class DefaultForm extends StatefulWidget {
  final List<FormFieldInfo> formFieldInfos;
  const DefaultForm({Key? key, required this.formFieldInfos}) : super(key: key);

  @override
  State<DefaultForm> createState() => _DefaultFormState();
}

class _DefaultFormState extends State<DefaultForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List forms = [];

    for (FormFieldInfo formField in widget.formFieldInfos) {
      forms.add(TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ));
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...forms,
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
