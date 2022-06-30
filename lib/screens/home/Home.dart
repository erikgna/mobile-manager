import 'package:flutter/material.dart';
import 'package:passwords_client/api/category_web.dart';
import 'package:passwords_client/api/password_web.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:passwords_client/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../models/password.dart';
import '../auth/Auth.dart';
import '../create_category/CreateCategory.dart';
import '../create_password/CreatePassword.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getAllData() async {
    final PasswordWebClient passWebClient = PasswordWebClient();
    final CategoryWebClient categoryWebClient = CategoryWebClient();

    return [
      await passWebClient.getPasswords(),
      await categoryWebClient.getCategories()
    ];
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();
    final PasswordProvider passwordController =
        context.watch<PasswordProvider>();

    String categorySelectorValue = '';

    return FutureBuilder<dynamic>(
        future: getAllData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final List<GestureDetector> passwords = [];
          if (snapshot.hasData) {
            passwordController.getPasswords(snapshot.data[0]);
            categoryController.getCategories(snapshot.data[1]);
            categorySelectorValue =
                categoryController.categories[0].categoryName!;

            for (Password pass in passwordController.passwords) {
              passwords.add(GestureDetector(
                onTap: () {},
                child: ListTile(
                    title: Text(pass.contentName!),
                    subtitle: Text(pass.password!),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.delete_outline_outlined),
                          onPressed: () {
                            passwordController.deletePassword(pass.id!);
                          }),
                    ])),
              ));
            }
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
                        child: Text('Login',
                            style: TextStyle(color: Colors.white)))
                    : TextButton(
                        onPressed: () async {
                          userController.logout();
                        },
                        child: Text('${userController.user?.userName} logout',
                            style: TextStyle(color: Colors.white)))
              ]),
              body: userController.user == null
                  ? Center(
                      child:
                          Text('Connect to your account to see your passwords'))
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
                                              title:
                                                  Text('No category registred'),
                                              content: Text(
                                                  'Please, register at least one category to create a password'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                  for (var category
                                      in categoryController.categories) {
                                    if (category.categoryName == value) {
                                      for (Password pass
                                          in passwordController.passwords) {
                                        passwords.add(GestureDetector(
                                          onTap: () {},
                                          child: ListTile(
                                              title: Text(pass.contentName!),
                                              subtitle: Text(pass.password!),
                                              trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                        icon: Icon(Icons.edit),
                                                        onPressed: () {}),
                                                    IconButton(
                                                        icon: Icon(Icons
                                                            .delete_outline_outlined),
                                                        onPressed: () {
                                                          passwordController
                                                              .deletePassword(
                                                                  pass.id!);
                                                        }),
                                                  ])),
                                        ));
                                      }
                                    }
                                  }

                                  setState(() {
                                    categorySelectorValue = value!;
                                  });
                                },
                                items: categoryController.categories
                                    .map<DropdownMenuItem<String>>(
                                        (var category) {
                                  return DropdownMenuItem<String>(
                                    value: category.categoryName,
                                    child: Text(category.categoryName!),
                                  );
                                }).toList()),
                        passwords.isEmpty
                            ? Center(child: Text('No passwords created yet.'))
                            : SizedBox.shrink(),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text('Are you sure?'),
                                        content: Text(
                                            'If you delete your account, you will lose all your passwords'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Dismiss')),
                                          TextButton(
                                              onPressed: () {
                                                userController.deleteUser();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete'))
                                        ]);
                                  });
                            },
                            child: Text('Delete account')),
                        ...passwords
                      ],
                    ));
        });
  }
}
