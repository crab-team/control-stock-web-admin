import 'package:control_stock_web_admin/domain/entities/commerce.dart';

class CommerceResponse {
  final int id;
  final String name;
  final String address;
  final double cashPaymentPercentage;

  CommerceResponse({
    required this.id,
    required this.name,
    required this.address,
    required this.cashPaymentPercentage,
  });

  factory CommerceResponse.fromJson(Map<String, dynamic> json) {
    return CommerceResponse(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      cashPaymentPercentage: json['cashPaymentPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'cashPaymentPercentage': cashPaymentPercentage,
    };
  }

  Commerce toDomain() {
    return Commerce(
      id: id,
      name: name,
      address: address,
      cashPaymentPercentage: cashPaymentPercentage,
    );
  }
}
