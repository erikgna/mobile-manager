import 'package:flutter/material.dart';
import 'package:passwords_client/components/default_form/DefaultForm.dart';
import 'package:passwords_client/models/form_field_info.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Register'),
      ),
      body: Column(children: [
        Text('Password Manager'),
        isLogin
            ? DefaultForm(formKey: _formKey, formFieldInfos: [
                FormFieldInfo(
                    hint: 'Email',
                    label: 'Email',
                    textController: emailController),
                FormFieldInfo(
                    hint: 'Password',
                    label: 'Password',
                    isPassword: true,
                    textController: passController)
              ])
            : DefaultForm(formKey: _formKey, formFieldInfos: [
                FormFieldInfo(
                    hint: 'Full name',
                    label: 'Full name',
                    textController: nameController),
                FormFieldInfo(
                    hint: 'Email',
                    label: 'Email',
                    textController: emailController),
                FormFieldInfo(
                    hint: 'Password',
                    label: 'Password',
                    isPassword: true,
                    textController: passController),
                FormFieldInfo(
                    hint: 'Confirm password',
                    label: 'Confirm password',
                    isPassword: true,
                    textController: confirmPassController),
              ]),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {}
            bool success = false;

            isLogin
                ? success = await userController.getUser()
                : success = await userController.saveUser();

            if (success) Navigator.of(context).pop();
          },
          child: Text(isLogin ? 'Login' : 'Register'),
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: isLogin
                      ? "Doesn't have an account? "
                      : "Already as an account? ",
                  style: TextStyle(color: Colors.black)),
              WidgetSpan(
                  child: GestureDetector(
                      child: Text(isLogin ? 'Signup here' : 'Signin here'),
                      onTap: () {
                        setState(() {
                          isLogin = isLogin ? false : true;
                        });
                      }))
            ])),
      ]),
    );
  }
}
