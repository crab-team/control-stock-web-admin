class PaymentMethodModel {
  final int? id;
  final String name;
  final int installments;
  final int surchargePercentage;

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
    int? surchargePercentage,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      installments: installments ?? this.installments,
      surchargePercentage: surchargePercentage ?? this.surchargePercentage,
    );
  }

  toCreatePaymentMethodJson() {
    return {
      'name': name,
      'installments': installments,
      'surchargePercentage': surchargePercentage,
    };
  }

  toUpdatePaymentMethodJson() {
    return {
      'id': id,
      'name': name,
      'installments': installments,
      'surchargePercentage': surchargePercentage,
    };
  }
}
