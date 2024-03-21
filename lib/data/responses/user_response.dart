import 'package:control_stock_web_admin/domain/entities/user.dart';

class UserResponse {
  String id;
  String email;
  String accessToken;
  String refreshToken;

  UserResponse({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserResponse.fromUser(User user) {
    return UserResponse(
      id: user.id,
      email: user.email,
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
    );
  }

  User toDomain() {
    return User(
      id: id,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
