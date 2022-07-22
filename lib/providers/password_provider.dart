import 'package:flutter/cupertino.dart';
import 'package:passwords_client/api/config/api_error.dart';
import 'package:passwords_client/api/password_web.dart';
import '../models/password.dart';

enum PasswordProviderState { success, loading, error }

class PasswordProvider extends ChangeNotifier {
  final PasswordWebClient _passwordWeb = PasswordWebClient();
  final List<Password> passwords = [];

  Future<Password?> getPassword(int id) async {
    try {
      return await _passwordWeb.getPassword(id);
    } catch (e) {
      return null;
    }
  }

  Future<void> getPasswords(List<Password> passes) async {
    try {
      passwords.clear();

      if (passes.isEmpty) {
        final List<Password> pass = await _passwordWeb.getPasswords();
        passwords.addAll(pass);

        notifyListeners();

        return;
      }

      passwords.addAll(passes);

      return;
    } catch (e) {
      return;
    }
  }

  Future<String> createPassword(Password password) async {
    try {
      final Password passwordCreated =
          await _passwordWeb.createPassword(password);

      passwords.add(passwordCreated);

      notifyListeners();

      return "Password created successfuly!";
    } on APIException catch (e) {
      return e.cause;
    }
  }

  Future<String> updatePassword(Password password) async {
    try {
      final Password response = await _passwordWeb.editPassword(password);
      passwords.removeWhere((element) => element.id == password.id);
      passwords.add(response);

      notifyListeners();

      return "Password updated successfuly!";
    } on APIException catch (e) {
      return e.cause;
    }
  }

  Future<String> deletePassword(int id) async {
    try {
      await _passwordWeb.deletePassword(id);
      passwords.removeWhere((password) => password.id == id);

      notifyListeners();

      return 'Password deleted successfuly!';
    } on APIException catch (e) {
      return e.cause;
    }
  }

  Future<void> deletePasswordOfCategory(int categoryID) async {
    passwords.removeWhere((pass) => pass.categoryID == categoryID);

    notifyListeners();
  }
}
