import 'package:control_stock_web_admin/data/models/customer_model.dart';

class Customer {
  final int? id;
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String? address;
  final double positiveBalance;

  Customer({
    this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.address,
    required this.positiveBalance,
  });

  toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'positiveBalance': positiveBalance,
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
      positiveBalance: map['positiveBalance'],
    );
  }

  copyWith({
    int? id,
    String? name,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    double? positiveBalance,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      positiveBalance: positiveBalance ?? this.positiveBalance,
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
      positiveBalance: positiveBalance,
    );
  }

  String get fullName => '$name $lastName';
}
