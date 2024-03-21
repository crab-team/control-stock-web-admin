class SignInCredentials {
  final String email;
  final String password;

  SignInCredentials({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SignInCredentials.fromJson(Map<String, dynamic> json) {
    return SignInCredentials(
      email: json['email'],
      password: json['password'],
    );
  }
}
