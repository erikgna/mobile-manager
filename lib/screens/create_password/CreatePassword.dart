import 'package:flutter/material.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  int selectedCategoryID = 0;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final PasswordProvider passwordProvider = context.watch<PasswordProvider>();

    final List<Category> categories = [
      Category(id: 1),
      Category(id: 2),
      Category(id: 3),
      Category(id: 4),
      Category(id: 5),
      Category(id: 6),
    ];

    final teste = [];
    for (Category cat in categories) {
      teste.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedCategoryID = cat.id!;
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: cat.id == selectedCategoryID ? Colors.blue : Colors.white,
            border: cat.id == selectedCategoryID
                ? null
                : Border.all(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(48)),
          ),
          child: Text('Entreterimento',
              style: cat.id == selectedCategoryID
                  ? TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )
                  : TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    )),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text(
            'Create password',
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
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
        leading: SizedBox.shrink(),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 32,
              bottom: 32,
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Text(
              'Here you can create passwords that will be protected on our database. Never forget a password again!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.25,
              ),
            ),
          ),
          SizedBox(height: 48),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name of the service relationed to the password'),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: contentController,
                      decoration:
                          getFormDecoration(context, true, 'Content name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (chegada) => chegada == null || chegada.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                    SizedBox(height: 32),
                    Text('Password that gives you the access'),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: getFormDecoration(context, true, 'Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (String? teste) {},
                      validator: (chegada) => chegada == null || chegada.isEmpty
                          ? "Can't be null"
                          : null,
                    ),
                  ],
                ),
              )),
          SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [SizedBox(width: 16), ...teste],
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ElevatedButton(
                  onPressed: () {
                    passwordProvider.createPassword(Password(
                        contentName: contentController.text,
                        password: passwordController.text));
                  },
                  child: Text('Save Password'))),
        ],
      ),
    );
  }
}
