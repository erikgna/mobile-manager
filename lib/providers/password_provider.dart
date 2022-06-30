import 'package:flutter/cupertino.dart';
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

  Future<bool> createPassword(Password password) async {
    try {
      final Password passwordCreated =
          await _passwordWeb.createPassword(password);

      passwords.add(passwordCreated);

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassword(Password password) async {
    try {
      await _passwordWeb.editPassword(password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePassword(int id) async {
    try {
      await _passwordWeb.deletePassword(id);
      passwords.removeWhere((password) => password.id == id);

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePasswordOfCategory(int categoryID) async {
    try {
      passwords.removeWhere((pass) => pass.categoryID == categoryID);

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }
}
