import 'package:expenses/model/user.dart';

abstract class UserRepository {
  Future<User> addUser({
    required String username,
    required String email,
    required String password,
  });
  Future<User> loginUser({required String email, required String password});
}
