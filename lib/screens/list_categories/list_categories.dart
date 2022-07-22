import 'package:flutter/material.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/category_password.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  int selectedCategoryID = 0;
  String selectedCategoryName = '';

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    final PasswordProvider passwordProvider = context.watch<PasswordProvider>();

    final categories = [];
    for (Category category in categoryProvider.categories) {
      categories.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedCategoryID = category.id!;
            selectedCategoryName = category.categoryName!;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color:
                category.id == selectedCategoryID ? Colors.blue : Colors.white,
            border: category.id == selectedCategoryID
                ? null
                : Border.all(color: Colors.blue),
            borderRadius: const BorderRadius.all(Radius.circular(48)),
          ),
          child: Text(category.categoryName!,
              style: category.id == selectedCategoryID
                  ? const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )
                  : const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    )),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 32),
          child: Text(
            'Your Categories',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        centerTitle: false,
        leadingWidth: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 8),
            child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
        leading: const SizedBox.shrink(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                bottom: 32,
                left: 24,
                right: 24,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'Here you can view, edit and delete your categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [const SizedBox(width: 16), ...categories],
              ),
            ),
            const SizedBox(height: 24),
            selectedCategoryID != 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Editing category: $selectedCategoryName'),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: textController,
                          decoration:
                              getFormDecoration(context, true, 'Category name'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? "Can't be null"
                              : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 32,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final String result = await categoryProvider
                                      .updateCategory(Category(
                                          id: selectedCategoryID,
                                          categoryName: textController.text));

                                  final snackBar =
                                      SnackBar(content: Text(result));

                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: const Text('Send Change'))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 32,
                            child: ElevatedButton(
                                onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm delete"),
                                          content: const Text(
                                              "If you confirm, this password registred will be permanently deleted"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('Close')),
                                            TextButton(
                                                onPressed: () async {
                                                  final String result =
                                                      await categoryProvider
                                                          .deleteCategory(
                                                              selectedCategoryID);

                                                  await passwordProvider
                                                      .deletePasswordOfCategory(
                                                          selectedCategoryID);

                                                  if (!mounted) return;
                                                  Navigator.of(context).pop();

                                                  final snackBar = SnackBar(
                                                      content: Text(result));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                },
                                                child: const Text('Confirm'))
                                          ],
                                        );
                                      },
                                    ),
                                child: const Text('Delete Category'))),
                      ],
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
