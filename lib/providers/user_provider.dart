import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:passwords_client/api/user_web.dart';
import 'package:passwords_client/models/token.dart';
import 'package:passwords_client/models/user.dart';

enum UserProviderState { success, loading, error }

class UserProvider extends ChangeNotifier {
  final UserWebClient _userWeb = UserWebClient();
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  User? user;

  UserProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await getUser();
    notifyListeners();
  }

  Future<bool> saveUser() async {
    try {
      final User userInput = User(
        email: 'teste2@email.com',
        userName: 'Teste',
        password: 'A234567@',
        confirmPassword: 'A234567@',
      );

      final Token token = await _userWeb.register(userInput);

      final decodedToken = JwtDecoder.decode(token.accessToken);

      user = User(
        id: decodedToken['id'],
        userName: decodedToken['name'],
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );

      storage.write(key: 'user', value: jsonEncode(user!.toJson()));

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getUser() async {
    try {
      final User userInput = User(
        email: 'teste2@email.com',
        password: 'A234567@',
      );

      final Token token = await _userWeb.login(userInput);

      final decodedToken = JwtDecoder.decode(token.accessToken);

      user = User(
        id: decodedToken['id'],
        userName: decodedToken['name'],
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );

      storage.write(key: 'user', value: jsonEncode(user!.toJson()));

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    user = null;

    notifyListeners();
  }

  Future<void> deleteUser() async {
    try {
      await _userWeb.deleteUser(user!);

      user = null;

      notifyListeners();
    } catch (e) {
      return;
    }
  }
}
