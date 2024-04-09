import 'package:control_stock_web_admin/data/models/payment_method_model.dart';

class PaymentMethod {
  final int? id;
  final String name;
  final int installments;
  final int surchargePercentage;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.installments,
    required this.surchargePercentage,
  });

  PaymentMethod copyWith({
    int? id,
    String? name,
    int? installments,
    int? surchargePercentage,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      installments: installments ?? this.installments,
      surchargePercentage: surchargePercentage ?? this.surchargePercentage,
    );
  }

  PaymentMethodModel toModel() {
    return PaymentMethodModel(
      id: id,
      name: name,
      installments: installments,
      surchargePercentage: surchargePercentage,
    );
  }
}
