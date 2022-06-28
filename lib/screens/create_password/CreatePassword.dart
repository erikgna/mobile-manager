import 'package:flutter/material.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

import '../../components/default_form/DefaultForm.dart';
import '../../models/form_field_info.dart';
import '../../providers/category_password.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();

    final PasswordProvider passwordController =
        context.watch<PasswordProvider>();

    String categorySelectorValue =
        categoryController.categories[0].categoryName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create password'),
      ),
      body: Column(children: [
        Text('Password Manager'),
        DefaultForm(formKey: _formKey, formFieldInfos: [
          FormFieldInfo(hint: 'Service name', label: 'Service name'),
          FormFieldInfo(hint: 'Password', label: 'Password', isPassword: true),
        ]),
        DropdownButton(
            value: categorySelectorValue,
            onChanged: (String? value) {
              setState(() {
                categorySelectorValue = value!;
              });
            },
            items: categoryController.categories
                .map<DropdownMenuItem<String>>((Category category) {
              return DropdownMenuItem<String>(
                value: category.categoryName,
                child: Text(category.categoryName),
              );
            }).toList()),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
            passwordController.createPassword();
          },
          child: const Text('Submit'),
        ),
      ]),
    );
  }
}
