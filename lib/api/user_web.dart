import 'dart:convert';

import 'package:http/http.dart';
import 'package:passwords_client/api/config/api_error.dart';
import 'package:passwords_client/models/token.dart';
import 'package:passwords_client/models/user.dart';

import 'config/webclient.dart';

class UserWebClient {
  Future<Token> login(User user) async {
    print(user.toJson());
    final Response response = await client.post(
      Uri.parse('http://192.168.3.6:3000/api/v1/user/login'),
      headers: {'Content-type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode(user.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<Token> register(User user) async {
    print(user.toJson());
    final Response response = await client.post(
        Uri.parse('http://192.168.3.6:3000/api/v1/user/create'),
        headers: {'Content-type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode(user.toJson()));

    print(response.body);
    if (response.statusCode == 201) {
      return Token.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<void> deleteUser(User user) async {
    final Response response = await client.post(
        Uri.parse('http://192.168.3.6:3000/api/v1/user/delete'),
        headers: {
          'Content-type': 'application/json',
          'Accept': '*/*',
          'refreshToken': user.refreshToken!,
          'authorization': 'Bearer ${user.accessToken!}'
        },
        body: jsonEncode(user.toJson()));

    if (response.statusCode == 200) return;

    throw APIException(response.body);
  }
}
