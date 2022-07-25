import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:passwords_client/providers/category_password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:passwords_client/providers/user_provider.dart';
import 'package:passwords_client/screens/auth/auth.dart';
import 'package:passwords_client/screens/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => PasswordProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userController = context.watch<UserProvider>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown,
        disabledColor: const Color.fromARGB(221, 75, 75, 75),
        errorColor: Colors.red,
        brightness: Brightness.light,
        fontFamily: 'Open Sans',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 30.0),
          bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            userController.user == null ? const Auth() : const Home(),
      },
    );
  }
}
