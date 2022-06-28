import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passwords_client/models/user.dart';

enum UserProviderState { success, loading, error }

class UserProvider extends ChangeNotifier {
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  User? user;

  UserProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await getUser();
    notifyListeners();
  }

  Future<void> saveUser() async {
    final Map<String, dynamic> userJson = User(1, 'teste@email.com', 'teste',
            '1234567', '1234567', 'accessToken', 'refreshToken', false)
        .toJson();

    storage.write(key: 'user', value: jsonEncode(userJson));

    user = User.fromJson(userJson);

    notifyListeners();
  }

  Future<void> getUser() async {
    final String? stringUser = await storage.read(key: 'user');
    if (stringUser == null) return;

    final Map<String, dynamic> decodedUser = jsonDecode(stringUser);

    user = User.fromJson(decodedUser);

    notifyListeners();
  }

  Future<void> deleteUser() async {
    try {
      await storage.delete(key: 'user');
      user = null;

      notifyListeners();
    } catch (e) {
      throw Error();
    }
  }
}
