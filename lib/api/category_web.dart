import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:passwords_client/api/config/api_error.dart';
import 'package:passwords_client/models/category.dart';

import 'config/webclient.dart';

class CategoryWebClient {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Category> getCategory(int id) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client
        .get(Uri.parse('http://10.0.2.2:3000/api/v1/category/$id'), headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'refreshToken': user['refreshToken'],
      'authorization': 'Bearer ${user['accessToken']}'
    });

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<List<Category>> getCategories() async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client
        .get(Uri.parse('http://10.0.2.2:3000/api/v1/category'), headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'refreshToken': user['refreshToken'],
      'authorization': 'Bearer ${user['accessToken']}'
    });

    if (response.statusCode == 200) {
      final List<Category> categories = [];

      final List decodedJson = jsonDecode(response.body);
      for (var category in decodedJson) {
        categories.add(Category.fromJson(category));
      }
      return categories;
    }

    throw APIException(response.body);
  }

  Future<Category> createCategory(Category category) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response =
        await client.post(Uri.parse('http://10.0.2.2:3000/api/v1/category'),
            headers: {
              'Content-type': 'application/json',
              'Accept': '*/*',
              'refreshToken': user['refreshToken'],
              'authorization': 'Bearer ${user['accessToken']}'
            },
            body: jsonEncode(category.toJson()));

    if (response.statusCode == 201) {
      return Category.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<Category> editCategory(Category category) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client.put(
        Uri.parse('http://10.0.2.2:3000/api/v1/category/${category.id}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': '*/*',
          'refreshToken': user['refreshToken'],
          'authorization': 'Bearer ${user['accessToken']}'
        },
        body: category.toJson());

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    }

    throw APIException(response.body);
  }

  Future<bool> deleteCategory(int id) async {
    final String? userFromStorage = await storage.read(key: 'user');
    final user = jsonDecode(userFromStorage!);

    final Response response = await client.delete(
      Uri.parse('http://10.0.2.2:3000/api/v1/category/$id'),
      headers: {
        'Content-type': 'application/json',
        'Accept': '*/*',
        'refreshToken': user['refreshToken'],
        'authorization': 'Bearer ${user['accessToken']}'
      },
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw APIException(response.body);
  }
}
