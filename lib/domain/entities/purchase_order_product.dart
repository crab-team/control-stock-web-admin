class PurchaseOrderProduct {
  final int id;
  final String code;
  final int quantity;
  final double unitPrice;

  PurchaseOrderProduct({
    required this.id,
    required this.code,
    required this.quantity,
    required this.unitPrice,
  });

  copyWith({
    int? id,
    String? code,
    int? quantity,
    double? unitPrice,
  }) {
    return PurchaseOrderProduct(
      id: id ?? this.id,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  toJson() {
    return {
      'id': id,
      'code': code,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}
