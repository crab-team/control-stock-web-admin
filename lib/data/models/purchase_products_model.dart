class PurchaseProductModel {
  final int? id;
  final int quantity;
  final double unitPrice;

  PurchaseProductModel({
    this.id,
    required this.quantity,
    required this.unitPrice,
  });

  factory PurchaseProductModel.fromJson(Map<String, dynamic> json) {
    return PurchaseProductModel(
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

  PurchaseProductModel copyWith({
    int? id,
    int? quantity,
    double? unitPrice,
  }) {
    return PurchaseProductModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  toCreateJson() {
    return {
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  toUpdateJson() {
    return {
      'id': id,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}

class PurchaseProductsModel {
  final List<PurchaseProductModel> products;
  final String paymentStatus;
  final int paymentMethodId;

  PurchaseProductsModel({
    required this.products,
    required this.paymentStatus,
    required this.paymentMethodId,
  });

  factory PurchaseProductsModel.fromJson(Map<String, dynamic> json) {
    return PurchaseProductsModel(
      products: List<PurchaseProductModel>.from(json['products'].map((x) => PurchaseProductModel.fromJson(x))),
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

  toCreateJson() {
    return {
      'products': products.map((e) => e.toCreateJson()).toList(),
      'paymentStatus': paymentStatus,
      'paymentMethodId': paymentMethodId,
    };
  }

  toUpdateJson() {
    return {
      'products': products.map((e) => e.toUpdateJson()).toList(),
      'paymentStatus': paymentStatus,
      'paymentMethodId': paymentMethodId,
    };
  }
}
