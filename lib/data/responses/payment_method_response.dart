import 'package:control_stock_web_admin/domain/entities/payment_method.dart';

class PaymentMethodResponse {
  final int id;
  final String name;
  final int installments;
  final int surchargePercentage;

  PaymentMethodResponse({
    required this.id,
    required this.name,
    required this.installments,
    required this.surchargePercentage,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) {
    return PaymentMethodResponse(
      id: json['id'],
      name: json['name'],
      installments: json['installments'],
      surchargePercentage: json['surchargePercentage'],
    );
  }

  PaymentMethod toDomain() {
    return PaymentMethod(
      id: id,
      name: name,
      installments: installments,
      surchargePercentage: surchargePercentage,
    );
  }
}
