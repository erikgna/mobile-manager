import 'package:flutter/material.dart';
import 'package:passwords_client/core/default_top_bar.dart';
import 'package:passwords_client/core/password_widget.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

import '../../core/category_widget.dart';
import '../../core/theme/form_field_theme.dart';
import '../../models/category.dart';
import '../../providers/category_password.dart';

class ListPasswords extends StatefulWidget {
  const ListPasswords({Key? key}) : super(key: key);

  @override
  State<ListPasswords> createState() => _ListPasswordsState();
}

class _ListPasswordsState extends State<ListPasswords> {
  Password editedPassword = Password(id: 0, categoryID: 0);

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    final PasswordProvider passwordsProvider =
        context.watch<PasswordProvider>();

    final passwords = [];
    for (Password pass in passwordsProvider.passwords) {
      passwords.add(PasswordWidget(
        pass: pass,
        changeFunction: () => setState(() {
          editedPassword = pass;
        }),
        deleteFunction: () async {
          final String result =
              await passwordsProvider.deletePassword(pass.id!);

          editedPassword = Password();

          if (!mounted) return;
          Navigator.of(context).pop();

          final snackBar = SnackBar(content: Text(result));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ));
    }

    final categories = [];
    for (Category category in categoryProvider.categories) {
      categories.add(CategoryWidget(
          changeFunction: () {
            setState(() {
              editedPassword.categoryID = category.id!;
            });
          },
          category: category,
          selectedCategoryID: editedPassword.categoryID!,
          selectedCategoryName: null));
    }

    String? fieldsValidation(String? value) {
      if (value == null || value == "") {
        return "Value can't be empty";
      }

      return null;
    }

    void updatePassword() async {
      final String result =
          await passwordsProvider.updatePassword(editedPassword);
      final snackBar = SnackBar(content: Text(result));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: defaultAppBar(title: 'Your Passwwords'),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultBigAppBar(
              description: 'Here you can view, edit and delete your passwords'),
          const SizedBox(height: 32),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [const SizedBox(width: 16), ...categories],
            ),
          ),
          editedPassword.categoryID == 0
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    const SizedBox(height: 32),
                    TextFormField(
                        onChanged: (String? value) =>
                            editedPassword.contentName = value,
                        decoration: getFormDecoration(
                            context,
                            true,
                            editedPassword.contentName == null
                                ? 'Content Name'
                                : 'Content name: ${editedPassword.contentName!}'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (String? val) {},
                        validator: fieldsValidation),
                    const SizedBox(height: 24),
                    TextFormField(
                        onChanged: (String? value) =>
                            editedPassword.password = value,
                        decoration: getFormDecoration(
                            context,
                            true,
                            editedPassword.password == null
                                ? 'Your password'
                                : 'Your password: ${editedPassword.password!}'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (String? teste) {},
                        validator: fieldsValidation),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: updatePassword,
                        child: const Text('Send Changes'))
                  ],
                ),
          const SizedBox(height: 24),
          ...passwords,
          const SizedBox(height: 24)
        ],
      )),
    );
  }
}
