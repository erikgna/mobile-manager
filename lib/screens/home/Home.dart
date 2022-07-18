// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_client/screens/create_category/CreateCategory.dart';
import 'package:passwords_client/screens/create_password/CreatePassword.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../list_categories/ListCategories.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.blue,
            ),
            padding: EdgeInsets.only(top: 64),
            height: 264,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Erik Gabriel Na',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Monday, 17 jan 2022',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Text(
                              '08',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Categories\n registred',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              '08',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Categories\n registred',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 204),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AccessBox(
                            click: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateCategory()),
                              );
                            },
                            icon: Icon(Icons.lock_clock_outlined),
                            title: "New category",
                            description: "Create new categories",
                          ),
                          SizedBox(width: 24),
                          AccessBox(
                            click: () {
                              Get.to(CreatePassword());
                            },
                            icon: Icon(Icons.lock_clock_outlined),
                            title: "New password",
                            description: "Create new password",
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AccessBox(
                            click: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListCategories()),
                              );
                            },
                            icon: Icon(Icons.lock_clock_outlined),
                            title: "List categories",
                            description: "See your categories",
                          ),
                          SizedBox(width: 24),
                          AccessBox(
                            click: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListCategories()),
                              );
                            },
                            icon: Icon(Icons.lock_clock_outlined),
                            title: "List passwords",
                            description: "See your passwords",
                          ),
                        ],
                      ),
                      SizedBox(height: 64),
                      Center(
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 32,
                            child: ElevatedButton(
                                onPressed: () => userController.deleteUser(),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                                child: Text(
                                    userController.user == null
                                        ? 'Logar Usuário'
                                        : 'Deslogar Usuário',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccessBox extends StatelessWidget {
  final void Function()? click;
  final Icon icon;
  final String title;
  final String description;

  const AccessBox({
    Key? key,
    required this.click,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        width: 156,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
