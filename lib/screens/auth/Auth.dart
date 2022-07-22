import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_client/models/user.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:passwords_client/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../../core/theme/form_field_theme.dart';
import '../../providers/user_provider.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();
    final PasswordProvider passwordController =
        context.watch<PasswordProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Text(
          isLogin ? 'Register' : 'Login',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 24),
            const Text(
              'Password Manager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            isLogin
                ? Column(children: [
                    TextFormField(
                      controller: emailController,
                      decoration: getFormDecoration(context, true, 'Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: nameController,
                      decoration: getFormDecoration(context, true, 'Full Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: passController,
                      decoration: getFormDecoration(context, true, 'Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: confirmPassController,
                      decoration:
                          getFormDecoration(context, true, 'Confirm Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    )
                  ])
                : Column(children: [
                    TextFormField(
                      controller: emailController,
                      decoration: getFormDecoration(context, true, 'Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: passController,
                      decoration: getFormDecoration(context, true, 'Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (value) => value == null || value.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                  ]),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () async {
                bool success = false;

                final User user = User(
                  email: emailController.text,
                  userName: nameController.text,
                  password: passController.text,
                  confirmPassword: confirmPassController.text,
                );

                isLogin
                    ? success = await userController.saveUser(user)
                    : success = await userController.getUser(userInput: user);

                if (success) {
                  categoryController.getCategories([]);
                  passwordController.getPasswords([]);
                  Get.to(const Home());
                }
              },
              child: Text(
                isLogin ? 'Register' : 'Login',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: isLogin
                          ? "Already has an account? "
                          : "Doesn't have an account? ",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                  WidgetSpan(
                      child: GestureDetector(
                          child: Text(
                            isLogin ? 'Signin here' : 'Signup here',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isLogin = isLogin ? false : true;
                            });
                          }))
                ])),
          ]),
        ),
      ),
    );
  }
}
