class PurchaseProducts {
  final List<PurchaseProduct> products;
  final String paymentStatus;
  final int paymentMethodId;

  PurchaseProducts({
    required this.products,
    required this.paymentStatus,
    required this.paymentMethodId,
  });

  factory PurchaseProducts.fromJson(Map<String, dynamic> json) {
    return PurchaseProducts(
      products: List<PurchaseProduct>.from(json['products'].map((x) => PurchaseProduct.fromJson(x))),
      paymentStatus: json['paymentStatus'],
      paymentMethodId: json['paymentMethodId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'paymentStatus': paymentStatus,
      'paymentMethodId': paymentMethodId,
    };
  }
}

class PurchaseProduct {
  final int id;
  final int quantity;
  final double unitPrice;

  PurchaseProduct({
    required this.id,
    required this.quantity,
    required this.unitPrice,
  });

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) {
    return PurchaseProduct(
      id: json['id'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}
