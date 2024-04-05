import 'package:control_stock_web_admin/data/responses/category_response.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';

class ProductResponse {
  int id;
  String code;
  String name;
  double costPrice;
  double publicPrice;
  double? cashPurchasePrice;
  int stock;
  CategoryResponse category;
  String qrCodeUrl;
  bool hasQrPrinted;

  ProductResponse({
    required this.id,
    required this.code,
    required this.name,
    required this.costPrice,
    required this.stock,
    required this.category,
    required this.qrCodeUrl,
    required this.publicPrice,
    required this.hasQrPrinted,
    this.cashPurchasePrice,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      costPrice: double.parse(json["costPrice"]),
      publicPrice: json["publicPrice"],
      cashPurchasePrice: json["cashPurchasePrice"],
      stock: json["stock"],
      category: CategoryResponse.fromJson(json["category"]),
      qrCodeUrl: json["qrCodeUrl"],
      hasQrPrinted: json["hasQrPrinted"],
    );
  }

  Product toDomain() {
    return Product(
      id: id,
      code: code,
      name: name,
      costPrice: costPrice,
      publicPrice: publicPrice,
      cashPurchasePrice: cashPurchasePrice,
      stock: stock,
      category: category.toDomain(),
      qrCodeUrl: qrCodeUrl,
      hasQrPrinted: hasQrPrinted,
    );
  }
}
