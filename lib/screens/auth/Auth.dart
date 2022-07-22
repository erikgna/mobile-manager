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
  final User editUser = User();
  final _formKey = GlobalKey<FormState>();
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();
    final CategoryProvider categoryController =
        context.watch<CategoryProvider>();
    final PasswordProvider passwordController =
        context.watch<PasswordProvider>();

    void authenticate() async {
      if (_formKey.currentState!.validate()) {
        final bool success = await userController.authenticate(
            userInput: editUser, isLogin: !isLogin);

        if (success) {
          categoryController.getCategories([]);
          passwordController.getPasswords([]);
          Get.to(const Home());
        }
      }
    }

    String? fieldsValidation(String? value) {
      if (value == null || value == "") {
        return "Value can't be empty";
      }

      return null;
    }

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
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        decoration: getFormDecoration(context, true, 'Email'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (String? value) => editUser.email = value,
                        validator: fieldsValidation),
                    isLogin
                        ? const SizedBox(height: 24)
                        : const SizedBox.shrink(),
                    isLogin
                        ? TextFormField(
                            decoration:
                                getFormDecoration(context, true, 'Full Name'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (String? value) =>
                                editUser.userName = value,
                            validator: fieldsValidation)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 24),
                    TextFormField(
                        decoration:
                            getFormDecoration(context, true, 'Password'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (String? value) => editUser.password = value,
                        validator: fieldsValidation),
                    isLogin
                        ? const SizedBox(height: 24)
                        : const SizedBox.shrink(),
                    isLogin
                        ? TextFormField(
                            decoration: getFormDecoration(
                                context, true, 'Confirm Password'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (String? value) =>
                                editUser.confirmPassword = value,
                            validator: fieldsValidation)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: authenticate,
                      child: Text(
                        isLogin ? 'Register' : 'Login',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )),
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
                          onTap: () => setState(() {
                                isLogin = isLogin ? false : true;
                              })))
                ])),
          ]),
        ),
      ),
    );
  }
}
