import 'package:control_stock_web_admin/domain/entities/commerce.dart';

class CommerceResponse {
  final int id;
  final String name;
  final String address;
  final double discountCashPercentage;

  CommerceResponse({
    required this.id,
    required this.name,
    required this.address,
    required this.discountCashPercentage,
  });

  factory CommerceResponse.fromJson(Map<String, dynamic> json) {
    return CommerceResponse(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      discountCashPercentage: json['discount_cash_percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'discount_cash_percentage': discountCashPercentage,
    };
  }

  Commerce toDomain() {
    return Commerce(
      id: id,
      name: name,
      address: address,
      discountCashPercentage: discountCashPercentage,
    );
  }
}
