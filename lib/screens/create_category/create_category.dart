import 'package:flutter/material.dart';
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
  int selectedCategoryID = 0;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 32),
          child: Text(
            'Create category',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        centerTitle: false,
        leadingWidth: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 8,
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
              'Here you can create categories to your passwords, that will maintain it more organizade and easy to use.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.25,
              ),
            ),
          ),
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
                        controller: textController,
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
                  onPressed: () async {
                    final String result = await categoryProvider.createCategory(
                        Category(categoryName: textController.text));

                    final snackBar = SnackBar(content: Text(result));

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Save Category'))),
        ],
      ),
    );
  }
}
