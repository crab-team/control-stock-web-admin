import 'package:control_stock_web_admin/data/models/client_model.dart';

class Client {
  final int? id;
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String? address;

  Client({
    this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.address,
  });

  @override
  String toString() {
    return 'Client{id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, address: $address}';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }

  copyWith({
    int? id,
    String? name,
    String? lastName,
    String? email,
    String? phone,
    String? address,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  ClientModel toModel() {
    return ClientModel(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      phone: phone,
      address: address,
    );
  }
}
