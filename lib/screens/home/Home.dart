import 'package:flutter/material.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:passwords_client/screens/auth/Auth.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../providers/user_provider.dart';
import '../create_category/CreateCategory.dart';
import '../create_password/CreatePassword.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();
    final PasswordProvider passwordController =
        context.watch<PasswordProvider>();
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();

    String categorySelectorValue = categoryController.categories.isEmpty
        ? ''
        : categoryController.categories.first.categoryName;

    final List<ListTile> passwords = [];
    for (Password pass in passwordController.passwords) {
      passwords.add(ListTile(
          title: Text(pass.contentName!),
          subtitle: Text(pass.password!),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.delete_outline_outlined),
                onPressed: () {
                  passwordController.deletePassword(pass.id);
                }),
          ])));
    }

    return Scaffold(
        appBar: AppBar(actions: [
          userController.user == null
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Auth()),
                    );
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white)))
              : TextButton(
                  onPressed: () async {
                    await userController.deleteUser();
                  },
                  child: Text('${userController.user?.userName} logout',
                      style: TextStyle(color: Colors.white)))
        ]),
        body: userController.user == null
            ? Center(
                child: Text('Connect to your account to see your passwords'))
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () async {
                            if (categoryController.categories.isEmpty) {
                              await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text('No category registred'),
                                        content: Text(
                                            'Please, register at least one category to create a password'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Dismiss'))
                                        ],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ));
                                  });
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatePassword()),
                            );
                          }),
                      IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateCategory()),
                            );
                          }),
                    ],
                  ),
                  categoryController.categories.isEmpty
                      ? SizedBox.shrink()
                      : DropdownButton(
                          value: categorySelectorValue,
                          onChanged: (String? value) {
                            passwords.clear();
                            for (Category category
                                in categoryController.categories) {
                              if (category.categoryName == value) {
                                for (Password pass
                                    in passwordController.passwords) {
                                  passwords.add(ListTile(
                                      title: Text(pass.contentName!),
                                      subtitle: Text(pass.password!),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(Icons
                                                    .delete_outline_outlined),
                                                onPressed: () {
                                                  passwordController
                                                      .deletePassword(pass.id);
                                                }),
                                          ])));
                                }
                              }
                            }

                            setState(() {
                              categorySelectorValue = value!;
                            });
                          },
                          items: categoryController.categories
                              .map<DropdownMenuItem<String>>(
                                  (Category category) {
                            return DropdownMenuItem<String>(
                              value: category.categoryName,
                              child: Text(category.categoryName),
                            );
                          }).toList()),
                  passwords.isEmpty
                      ? Center(child: Text('No passwords created yet.'))
                      : SizedBox.shrink(),
                  ...passwords
                ],
              ));
  }
}
