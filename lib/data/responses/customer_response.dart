import 'package:control_stock_web_admin/domain/entities/customer.dart';

class CustomerResponse {
  final int id;
  final String name;
  final String lastName;
  final double balance;
  final String? email;
  final String? phone;
  final String? address;

  CustomerResponse({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
    this.email,
    this.phone,
    this.address,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      id: json["id"],
      name: json["name"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      balance: json["balance"],
    );
  }

  Customer toDomain() {
    return Customer(
      id: id,
      name: name,
      lastName: lastName,
      email: email ?? '',
      phone: phone ?? '',
      address: address ?? '',
      balance: balance,
    );
  }
}
