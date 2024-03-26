import 'package:control_stock_web_admin/data/models/product_model.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';

class Product {
  final int? id;
  final String code;
  final String name;
  final double costPrice;
  final double? publicPrice;
  final int stock;
  final Category category;
  final String? imageUrl;
  final String? qrCodeUrl;

  Product({
    this.id,
    required this.code,
    required this.name,
    required this.category,
    required this.costPrice,
    required this.stock,
    this.imageUrl,
    this.qrCodeUrl,
    this.publicPrice,
  });

  toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'category': category,
      'costPrice': costPrice,
      'stock': stock,
      'imageUrl': imageUrl,
      'qrUrl': qrCodeUrl,
      'publicPrice': publicPrice,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      category: json['category'],
      costPrice: json['costPrice'],
      publicPrice: json['publicPrice'],
      stock: json['stock'],
      imageUrl: json['imageUrl'],
      qrCodeUrl: json['qrCodeUrl'],
    );
  }

  copyWith({
    int? id,
    String? code,
    String? name,
    double? costPrice,
    double? publicPrice,
    int? stock,
    Category? category,
    String? imageUrl,
    String? qrCodeUrl,
  }) {
    return Product(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      costPrice: costPrice ?? this.costPrice,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
      qrCodeUrl: qrCodeUrl ?? this.qrCodeUrl,
      publicPrice: publicPrice ?? this.publicPrice,
    );
  }

  ProductModel toCreateProductJson() {
    return ProductModel(
      code: code,
      name: name,
      costPrice: costPrice,
      stock: stock,
      categoryId: category.id,
    );
  }

  ProductModel toUpdateProductJson() {
    return ProductModel(
      id: id,
      code: code,
      name: name,
      costPrice: costPrice,
      stock: stock,
      categoryId: category.id,
      imageUrl: imageUrl,
    );
  }
}
