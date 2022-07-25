import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_client/core/default_top_bar.dart';
import 'package:passwords_client/core/category_widget.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  int selectedCategoryID = 0;
  final Password editPassword = Password();

  @override
  Widget build(BuildContext context) {
    final PasswordProvider passwordProvider = context.watch<PasswordProvider>();
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();

    final List categories = [];
    for (Category category in categoryProvider.categories) {
      categories.add(CategoryWidget(
          changeFunction: () => setState(() {
                selectedCategoryID = category.id!;
                editPassword.categoryID = category.id!;
              }),
          category: category,
          selectedCategoryID: selectedCategoryID,
          selectedCategoryName: null));
    }

    void createPassword() async {
      final String result = await passwordProvider.createPassword(editPassword);

      final snackBar = SnackBar(content: Text(result));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Get.back();
    }

    String? passwordChecker(String? value) {
      if (value == null || value == '') {
        return "Can't be empty";
      }
      return null;
    }

    return Scaffold(
      appBar: defaultAppBar(title: 'Create Password'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            defaultBigAppBar(
                context: context,
                description:
                    'Here you can create passwords that will be protected on our database. Never forget a password again!'),
            const SizedBox(height: 48),
            categories.isEmpty
                ? const Center(
                    child: Text(
                    'First, create a category!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
                : const SizedBox.shrink(),
            selectedCategoryID == 0
                ? categories.isEmpty
                    ? const SizedBox.shrink()
                    : const Text(
                        'Select a category!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              'Name of the service relationed to the password'),
                          const SizedBox(height: 16),
                          TextFormField(
                              onChanged: (String? value) =>
                                  editPassword.contentName = value,
                              decoration: getFormDecoration(
                                  context, true, 'Content name'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: passwordChecker),
                          const SizedBox(height: 32),
                          const Text('Password that gives you the access'),
                          const SizedBox(height: 16),
                          TextFormField(
                              onChanged: (String? value) =>
                                  editPassword.password = value,
                              decoration:
                                  getFormDecoration(context, true, 'Password'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: passwordChecker),
                        ],
                      ),
                    )),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  ...categories,
                ],
              ),
            ),
            const SizedBox(height: 32),
            selectedCategoryID == 0
                ? const SizedBox.shrink()
                : SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: ElevatedButton(
                        onPressed: createPassword,
                        child: const Text('Save Password'))),
          ],
        ),
      ),
    );
  }
}
