class CommerceModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;

  CommerceModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  factory CommerceModel.fromJson(Map<String, dynamic> json) {
    return CommerceModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }
}
