import 'package:flutter/material.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

import '../../core/theme/form_field_theme.dart';
import '../../models/category.dart';
import '../../providers/category_password.dart';

class ListPasswords extends StatefulWidget {
  const ListPasswords({Key? key}) : super(key: key);

  @override
  State<ListPasswords> createState() => _ListPasswordsState();
}

class _ListPasswordsState extends State<ListPasswords> {
  Password editedPassword = Password();

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController contentNameController = TextEditingController();
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    final PasswordProvider passwordsProvider =
        context.watch<PasswordProvider>();

    final passwords = [];
    for (Password pass in passwordsProvider.passwords) {
      passwords.add(GestureDetector(
          onTap: () {},
          child: ListTile(
            title: Text(pass.contentName!),
            subtitle: Text(pass.password!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        editedPassword = pass;
                      });
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm delete"),
                            content: const Text(
                                "If you confirm, this password registred will be permanently deleted"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Close')),
                              TextButton(
                                  onPressed: () async {
                                    final String result =
                                        await passwordsProvider
                                            .deletePassword(pass.id!);

                                    editedPassword = Password();

                                    if (!mounted) return;
                                    Navigator.of(context).pop();

                                    final snackBar =
                                        SnackBar(content: Text(result));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: const Text('Confirm'))
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          )));
    }

    final categories = [];
    for (Category category in categoryProvider.categories) {
      categories.add(GestureDetector(
        onTap: () {
          setState(() {
            editedPassword.categoryID = category.id;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: category.id == editedPassword.categoryID
                ? Colors.blue
                : Colors.white,
            border: category.id == editedPassword.categoryID
                ? null
                : Border.all(color: Colors.blue),
            borderRadius: const BorderRadius.all(Radius.circular(48)),
          ),
          child: Text(category.categoryName!,
              style: category.id == editedPassword.categoryID
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
            'Your Passwords',
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
              'Here you can view, edit and delete your passwords',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 32),
          editedPassword.categoryID == null
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [const SizedBox(width: 16), ...categories],
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: contentNameController,
                      decoration: getFormDecoration(
                          context,
                          true,
                          editedPassword.contentName == null
                              ? 'Content Name'
                              : 'Content name: ${editedPassword.contentName!}'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? val) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: passwordController,
                      decoration: getFormDecoration(
                          context,
                          true,
                          editedPassword.password == null
                              ? 'Your password'
                              : 'Your password: ${editedPassword.password!}'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () async {
                          editedPassword.contentName =
                              contentNameController.text;
                          editedPassword.password = passwordController.text;

                          final String result = await passwordsProvider
                              .updatePassword(editedPassword);
                          final snackBar = SnackBar(content: Text(result));

                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
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
