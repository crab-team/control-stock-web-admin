import 'package:control_stock_web_admin/data/models/customer_model.dart';

class Customer {
  final int? id;
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String? address;
  final double balance;

  Customer({
    this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.address,
    required this.balance,
  });

  toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'balance': balance,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      balance: map['balance'],
    );
  }

  copyWith({
    int? id,
    String? name,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    double? balance,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      balance: balance ?? this.balance,
    );
  }

  CustomerModel toModel() {
    return CustomerModel(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      phone: phone,
      address: address,
      balance: balance,
    );
  }

  String get fullName => '$name $lastName';
}
