import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_client/core/category_widget.dart';
import 'package:passwords_client/core/default_top_bar.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:passwords_client/utils/confirm_delete.dart';
import 'package:provider/provider.dart';

import '../../providers/category_password.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  String selectedCategoryName = '';
  final Category editeCategory = Category(id: 0);

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    final PasswordProvider passwordProvider = context.watch<PasswordProvider>();

    final categories = [];
    for (Category category in categoryProvider.categories) {
      categories.add(CategoryWidget(
          changeFunction: () => setState(() {
                editeCategory.id = category.id;
              }),
          category: category,
          selectedCategoryID: editeCategory.id!,
          selectedCategoryName: selectedCategoryName));
    }

    void updateCategory() async {
      final String result =
          await categoryProvider.updateCategory(editeCategory);

      if (result == 'Category updated successfuly!') {
        selectedCategoryName = editeCategory.categoryName!;
      }

      final snackBar = SnackBar(content: Text(result));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      FocusManager.instance.primaryFocus?.unfocus();
    }

    void deleteCategory() async {
      final String result =
          await categoryProvider.deleteCategory(editeCategory.id!);

      await passwordProvider.deletePasswordOfCategory(editeCategory.id!);

      if (!mounted) return;

      Get.back();

      final snackBar = SnackBar(content: Text(result));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: defaultAppBar(title: 'Your Categories'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultBigAppBar(
                description:
                    'Here you can view, edit and delete your categories'),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [const SizedBox(width: 16), ...categories],
              ),
            ),
            const SizedBox(height: 24),
            editeCategory.id != 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Editing category: $selectedCategoryName'),
                          const SizedBox(height: 16),
                          TextFormField(
                              onChanged: (String? value) =>
                                  editeCategory.categoryName = value,
                              decoration: getFormDecoration(
                                  context, true, 'Category name'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return "Can't be empty";
                                }
                                if (value.length <= 3) {
                                  return "Must have at least 4 letters";
                                }
                                return null;
                              }),
                          const SizedBox(height: 24),
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 32,
                              child: ElevatedButton(
                                  onPressed: updateCategory,
                                  child: const Text('Send Change'))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 32,
                              child: ElevatedButton(
                                  onPressed: () =>
                                      callDeleteDialog(context, deleteCategory),
                                  child: const Text('Delete Category'))),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
