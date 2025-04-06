import 'package:expenses/model/user.dart';

class UserDto {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'username': user.username,
      'email': user.email,
      // 'hashed_pass': user.hashed_pass,
    };
  }
}
