import 'package:control_stock_web_admin/domain/entities/commerce.dart';

class CommerceResponse {
  final int id;
  final String name;
  final String? address;
  final String? phone;
  final String? email;

  CommerceResponse({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.email,
  });

  factory CommerceResponse.fromJson(Map<String, dynamic> json) {
    return CommerceResponse(
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

  Commerce toDomain() {
    return Commerce(
      id: id,
      name: name,
      address: address ?? '',
      phone: phone ?? '',
      email: email ?? '',
    );
  }
}
