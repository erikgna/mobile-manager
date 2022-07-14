import 'package:flutter/material.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

import '../../components/default_form/DefaultForm.dart';
import '../../models/form_field_info.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  bool isEdit = false;
  int categoryID = 0;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();

    final PasswordProvider passwordController =
        context.watch<PasswordProvider>();

    final List<ListTile> categoriesWidget = [];
    for (Category category in categoryController.categories) {
      categoriesWidget.add(ListTile(
          title: Text(category.categoryName!),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    isEdit = true;
                    categoryID = category.id!;
                    textController.text = category.categoryName!;
                  });
                }),
            IconButton(
                icon: Icon(Icons.delete_outline_outlined),
                onPressed: () async {
                  await categoryController.deleteCategory(category.id!);
                  await passwordController
                      .deletePasswordOfCategory(category.id!);
                }),
          ])));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create category'),
      ),
      body: Column(children: [
        Text('Password Manager'),
        DefaultForm(formKey: _formKey, formFieldInfos: [
          FormFieldInfo(
            hint: 'Category name',
            label: 'Category name',
            textController: textController,
          ),
        ]),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {}

            categoryController
                .createCategory(Category(categoryName: textController.text));
          },
          child: const Text('Submit'),
        ),
        isEdit
            ? ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}

                  categoryController.updateCategory(Category(
                      id: categoryID, categoryName: textController.text));

                  setState(() {
                    categoryID = 0;
                    isEdit = false;
                  });
                },
                child: const Text('Send Edition'),
              )
            : SizedBox.shrink(),
        ...categoriesWidget
      ]),
    );
  }
}
