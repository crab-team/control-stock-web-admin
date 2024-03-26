class User {
  int id;
  String email;
  String accessToken;
  String refreshToken;

  User({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
