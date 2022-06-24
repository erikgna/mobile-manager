import 'package:flutter/material.dart';
import 'package:passwords_client/components/default_form/DefaultForm.dart';
import 'package:passwords_client/models/form_field_info.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(children: [
        Text('Password Manager'),
        DefaultForm(formFieldInfos: [
          FormFieldInfo('Email', 'Email'),
          FormFieldInfo('Password', 'Password')
        ]),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "Doesn't have an account? ",
                  style: TextStyle(color: Colors.black)),
              WidgetSpan(
                  child:
                      GestureDetector(child: Text('Signup here'), onTap: () {}))
            ])),
      ]),
    );
  }
}
