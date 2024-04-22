class PaymentMethodModel {
  final int? id;
  final String name;
  final int installments;
  final double surchargePercentage;

  PaymentMethodModel({
    this.id,
    required this.name,
    required this.installments,
    required this.surchargePercentage,
  });

  PaymentMethodModel copyWith({
    int? id,
    String? name,
    int? installments,
    double? surchargePercentage,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      installments: installments ?? this.installments,
      surchargePercentage: surchargePercentage ?? this.surchargePercentage,
    );
  }

  toCreatePaymentMethod() {
    return {
      'name': name,
      'installments': installments,
      'surchargePercentage': surchargePercentage,
    };
  }

  toUpdatePaymentMethod() {
    return {
      'id': id,
      'name': name,
      'installments': installments,
      'surchargePercentage': surchargePercentage,
    };
  }
}
