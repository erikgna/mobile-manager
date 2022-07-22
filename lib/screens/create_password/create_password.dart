import 'package:flutter/material.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/category_password.dart';
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
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();

    final categories = [];
    for (Category category in categoryProvider.categories) {
      categories.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedCategoryID = category.id!;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color:
                category.id == selectedCategoryID ? Colors.blue : Colors.white,
            border: category.id == selectedCategoryID
                ? null
                : Border.all(color: Colors.blue),
            borderRadius: const BorderRadius.all(Radius.circular(48)),
          ),
          child: Text('Entreterimento',
              style: category.id == selectedCategoryID
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
        title: const Padding(
          padding: EdgeInsets.only(top: 32),
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
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 32,
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Text(
                'Here you can create passwords that will be protected on our database. Never forget a password again!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Name of the service relationed to the password'),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: contentController,
                        decoration:
                            getFormDecoration(context, true, 'Content name'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (String? teste) {},
                        validator: (chegada) =>
                            chegada == null || chegada.isEmpty
                                ? "Can't be null"
                                : null,
                      ),
                      const SizedBox(height: 32),
                      const Text('Password that gives you the access'),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            getFormDecoration(context, true, 'Password'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (String? teste) {},
                        validator: (chegada) =>
                            chegada == null || chegada.isEmpty
                                ? "Can't be null"
                                : null,
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [const SizedBox(width: 16), ...categories],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: ElevatedButton(
                    onPressed: () async {
                      final String result =
                          await passwordProvider.createPassword(Password(
                              categoryID: selectedCategoryID,
                              contentName: contentController.text,
                              password: passwordController.text));

                      final snackBar = SnackBar(content: Text(result));

                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Text('Save Password'))),
          ],
        ),
      ),
    );
  }
}
