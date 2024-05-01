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
  final int viewId;
  final String? code;
  final int? quantity;
  final int? productId;
  final int? maxStock;
  final double? unitPrice;
  final String? name;

  PurchaseProduct({
    required this.viewId,
    this.productId,
    this.quantity,
    this.unitPrice,
    this.code,
    this.name,
    this.maxStock,
  });

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) {
    return PurchaseProduct(
      viewId: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      code: json['code'],
      name: json['name'],
      maxStock: json['maxStock'],
    );
  }

  copyWith({
    int? viewId,
    int? productId,
    int? quantity,
    double? unitPrice,
    String? code,
    String? name,
    int? maxStock,
  }) {
    return PurchaseProduct(
      viewId: viewId ?? this.viewId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      code: code ?? this.code,
      name: name ?? this.name,
      maxStock: maxStock ?? this.maxStock,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'viewId': viewId,
      'productId': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'code': code,
      'name': name,
      'maxStock': maxStock,
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  PurchaseProductModel toModel() {
    return PurchaseProductModel(
      id: productId,
      quantity: quantity ?? 0,
      unitPrice: unitPrice ?? 0,
    );
  }
}
