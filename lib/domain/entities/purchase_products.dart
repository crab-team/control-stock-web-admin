import 'package:control_stock_web_admin/data/models/purchase_products_model.dart';

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
  final String? code;
  final int quantity;
  final double unitPrice;
  final String? name;

  PurchaseProduct({
    required this.id,
    required this.quantity,
    required this.unitPrice,
    this.code,
    this.name,
  });

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) {
    return PurchaseProduct(
      id: json['id'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      code: json['code'],
      name: json['name'],
    );
  }

  copyWith({
    int? id,
    int? quantity,
    double? unitPrice,
    String? code,
    String? name,
  }) {
    return PurchaseProduct(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'code': code,
      'name': name,
    };
  }

  PurchaseProductModel toModel() {
    return PurchaseProductModel(
      id: id,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }
}
