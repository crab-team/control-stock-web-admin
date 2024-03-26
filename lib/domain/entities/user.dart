class User {
  int id;
  String username;
  String email;
  String accessToken;
  String refreshToken;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
