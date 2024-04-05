import 'package:control_stock_web_admin/domain/entities/category.dart';

class CategoryResponse {
  final int id;
  final String name;
  final double profitPercentage;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.profitPercentage,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      profitPercentage: double.parse(json['profitPercentage']),
    );
  }

  Category toDomain() {
    return Category(
      id: id,
      name: name,
      percentageProfit: profitPercentage,
    );
  }
}
