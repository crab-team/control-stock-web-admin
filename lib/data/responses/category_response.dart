import 'package:control_stock_web_admin/domain/entities/category.dart';

class CategoryResponse {
  final int id;
  final String name;
  final double profitPercentage;
  final double extraCosts;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.profitPercentage,
    required this.extraCosts,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      profitPercentage: json['profitPercentage'],
      extraCosts: json['extraCosts'],
    );
  }

  Category toDomain() {
    return Category(
      id: id,
      name: name,
      percentageProfit: profitPercentage,
      extraCosts: extraCosts,
    );
  }
}
