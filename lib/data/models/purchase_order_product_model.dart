class PurchaseOrderProductModel {
  final int id;
  final double unitPrice;
  final int quantity;

  PurchaseOrderProductModel({
    required this.id,
    required this.unitPrice,
    required this.quantity,
  });

  copyWith({
    int? id,
    String? name,
    double? unitPrice,
    int? quantity,
  }) {
    return PurchaseOrderProductModel(
      id: id ?? this.id,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  toJson() {
    return {
      'id': id,
      'unitPrice': unitPrice,
      'quantity': quantity,
    };
  }

  toCreateJson() {
    return {
      'id': id,
      'unitPrice': unitPrice,
      'quantity': quantity,
    };
  }
}
