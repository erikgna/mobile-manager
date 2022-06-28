import 'package:flutter/cupertino.dart';
import '../models/password.dart';

enum PasswordProviderState { success, loading, error }

class PasswordProvider extends ChangeNotifier {
  final List<Password> passwords = [Password(1, 'Amazon', '12345678', 1, 1)];

  Future<void> getPasswords() async {
    passwords.add(Password(2, 'Netflix', '12345678', 1, 1));

    notifyListeners();
  }

  Future<void> createPassword() async {
    passwords.add(Password(2, 'Netflix', '12345678', 2, 1));

    notifyListeners();
  }

  Future<void> deletePassword(int id) async {
    passwords.removeWhere(((Password pass) => pass.id == id));

    notifyListeners();
  }
}
