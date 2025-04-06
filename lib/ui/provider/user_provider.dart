import 'package:expenses/model/user.dart';
import 'package:expenses/repository/user_repository.dart';
import 'package:expenses/utils/async_value.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository;
  AsyncValue<List<User>>? userState;
  UserProvider(this._repository);
  bool get isLoading =>
      userState != null && userState!.state == AsyncValueState.loading;
  bool get hasData =>
      userState != null && userState!.state == AsyncValueState.success;

  Future<User> addUser(
    String username,
    String email,
    String hashed_pass,
  ) async {
    final user = await _repository.addUser(
      username: username,
      email: email,
      password: hashed_pass,
    );
    notifyListeners();
    return user;
  }

  Future<User> login(String email, String password) async {
    final user = await _repository.loginUser(email: email, password: password);
    notifyListeners();
    return user;
  }
}
