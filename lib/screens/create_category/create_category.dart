import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_client/core/default_top_bar.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    final Category editCategory = Category();
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();

    void createCategory() async {
      final String result = await categoryProvider.createCategory(editCategory);

      final snackBar = SnackBar(content: Text(result));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Get.back();
    }

    return Scaffold(
      appBar: defaultAppBar(title: 'Create Category'),
      body: Column(
        children: [
          defaultBigAppBar(
              description:
                  'Here you can create categories to your passwords, that will maintain it more organizade and easy to use.'),
          const SizedBox(height: 48),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name of the category'),
                    const SizedBox(height: 16),
                    TextFormField(
                        onChanged: (String? value) =>
                            editCategory.categoryName = value,
                        decoration:
                            getFormDecoration(context, true, 'Category'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Can't be empty";
                          }
                          if (value.length <= 3) {
                            return "Must have at least 4 letters";
                          }
                          return null;
                        }),
                  ],
                ),
              )),
          const SizedBox(height: 32),
          SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ElevatedButton(
                  onPressed: createCategory,
                  child: const Text('Save Category'))),
        ],
      ),
    );
  }
}
