import 'dart:convert';
import 'dart:io';

import 'package:expenses/dto/user_dto.dart';
import 'package:expenses/model/user.dart';
import 'package:expenses/repository/user_repository.dart';
import 'package:http/http.dart' as http;

class SqliteUserRepo extends UserRepository {
  static const String baseUrl = "http://localhost:5000/auth";
  final Uri uri = Uri.parse(baseUrl);
  @override
  Future<User> addUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      Uri uriRegis = Uri.parse('$baseUrl/register');
      final newUser = {
        'username': username,
        'email': email,
        'password': password, // raw password as expected by your backend
      };
      final http.Response response = await http.post(
        uriRegis,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newUser),
      );
      if (response.statusCode == HttpStatus.created ||
          response.statusCode == HttpStatus.ok) {
        final responseData = json.decode(response.body);
        final rawId = responseData['id'];

        late int userId;

        if (rawId is Map && rawId.containsKey('userId')) {
          userId = rawId['userId'];
        } else if (rawId is int) {
          userId = rawId;
        } else {
          throw Exception("Unexpected 'id' format: $rawId");
        }

        return User(id: userId, username: username, email: email);
      }
      throw Exception('Failed to register: ${response.statusCode}');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<User> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      Uri uriLogin = Uri.parse('$baseUrl/login');
      final loginData = {'email': email, 'password': password};
      final http.Response response = await http.post(
        uriLogin,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginData),
      );
      if (response.statusCode == HttpStatus.ok) {
        final responseData = json.decode(response.body);
        final userJson = responseData['user'];
        return UserDto.fromJson(userJson);
      }
      throw Exception('Failed to login: ${response.statusCode}');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
