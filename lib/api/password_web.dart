import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:passwords_client/api/config/api_error.dart';
import 'package:passwords_client/models/password.dart';

import 'config/url_constant.dart';
import 'config/webclient.dart';

class PasswordWebClient {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Password> getPassword(int id) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client
        .get(Uri.parse('$computerUrl/api/v1/password/$id'), headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'refreshToken': user['refreshToken'],
      'authorization': 'Bearer ${user['accessToken']}'
    });

    if (response.statusCode == 200) {
      return Password.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<List<Password>> getPasswords() async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response =
        await client.get(Uri.parse('$computerUrl/api/v1/password'), headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'refreshToken': user['refreshToken'],
      'authorization': 'Bearer ${user['accessToken']}'
    });

    if (response.statusCode == 200) {
      final List<Password> passwords = [];

      final List decodedJson = jsonDecode(response.body);
      for (var pass in decodedJson) {
        passwords.add(Password.fromJson(pass));
      }
      return passwords;
    }

    throw APIException(response.body);
  }

  Future<Password> createPassword(Password password) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response =
        await client.post(Uri.parse('$computerUrl/api/v1/password'),
            headers: {
              'Content-type': 'application/json',
              'Accept': '*/*',
              'refreshToken': user['refreshToken'],
              'authorization': 'Bearer ${user['accessToken']}'
            },
            body: jsonEncode(password.toJson()));

    if (response.statusCode == 201) {
      return Password.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<Password> editPassword(Password password) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client.put(
        Uri.parse('$computerUrl/api/v1/password/${password.id}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': '*/*',
          'refreshToken': user['refreshToken'],
          'authorization': 'Bearer ${user['accessToken']}'
        },
        body: jsonEncode(password.toJson()));

    if (response.statusCode == 200) {
      return Password.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<void> deletePassword(int id) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client.delete(
      Uri.parse('$computerUrl/api/v1/password/$id'),
      headers: {
        'Content-type': 'application/json',
        'Accept': '*/*',
        'refreshToken': user['refreshToken'],
        'authorization': 'Bearer ${user['accessToken']}'
      },
    );

    if (response.statusCode == 200) {
      return;
    }

    throw APIException(response.body);
  }
}
