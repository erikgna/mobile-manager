import 'package:flutter/material.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:provider/provider.dart';

import '../../components/default_form/DefaultForm.dart';
import '../../models/form_field_info.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create category'),
      ),
      body: Column(children: [
        Text('Password Manager'),
        DefaultForm(formKey: _formKey, formFieldInfos: [
          FormFieldInfo(hint: 'Category name', label: 'Category name'),
        ]),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
            categoryController.getCategories();
          },
          child: const Text('Submit'),
        ),
      ]),
    );
  }
}
