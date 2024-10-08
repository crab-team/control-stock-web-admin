class PurchaseModel {
  int? id;
  int productId;
  int quantity;
  double unitPrice;
  int paymentMethodId;

  PurchaseModel({
    this.id,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.paymentMethodId,
  });

  PurchaseModel copyWith({
    int? id,
    int? productId,
    String? paymentStatus,
    int? quantity,
    double? unitPrice,
    int? paymentMethodId,
  }) {
    return PurchaseModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }

  toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'paymentMethodId': paymentMethodId,
    };
  }

  toCreate() {
    return {
      'productId': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'paymentMethodId': paymentMethodId,
    };
  }
}
