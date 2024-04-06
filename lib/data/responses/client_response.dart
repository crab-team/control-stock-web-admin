import 'package:control_stock_web_admin/domain/entities/client.dart';

class ClientResponse {
  final int id;
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String? address;

  ClientResponse({
    required this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.address,
  });

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      id: json["id"],
      name: json["name"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
    );
  }

  Client toDomain() {
    return Client(
      id: id,
      name: name,
      lastName: lastName,
      email: email ?? '',
      phone: phone ?? '',
      address: address ?? '',
    );
  }
}
