import 'package:control_stock_web_admin/domain/entities/user.dart';

class UserResponse {
  int id;
  String username;
  String email;
  String accessToken;
  String refreshToken;

  UserResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserResponse.fromUser(User user) {
    return UserResponse(
      id: user.id,
      username: user.username,
      email: user.email,
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
    );
  }

  User toDomain() {
    return User(
      id: id,
      username: username,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
