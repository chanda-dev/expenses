import 'package:expenses/model/user.dart';

class UserDto {
  static User fronJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      hashedPass: json['hashedPass'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'username': user.username,
      'email': user.email,
      'hashedPass': user.hashedPass,
    };
  }
}
