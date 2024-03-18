// Products
import 'package:control_stock_web_admin/domain/use_cases/categories/create_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/delete_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/get_categories.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/update_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/create_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/delete_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/get_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/get_products.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/update_product.dart';
import 'package:control_stock_web_admin/providers/repositories_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Products
final getProductsUseCaseProvider = Provider<GetProducts>((ref) {
  return GetProducts(ref.read(productsRepositoryProvider));
});

final getProductUseCaseProvider = Provider<GetProduct>((ref) {
  return GetProduct(ref.read(productsRepositoryProvider));
});

final updateProductUseCaseProvider = Provider<UpdateProduct>((ref) {
  return UpdateProduct(ref.read(productsRepositoryProvider));
});

final createProductUseCaseProvider = Provider<CreateProduct>((ref) {
  return CreateProduct(ref.read(productsRepositoryProvider));
});

final deleteProductUseCaseProvider = Provider<DeleteProduct>((ref) {
  return DeleteProduct(ref.read(productsRepositoryProvider));
});

// Categories
final getCategoriesUseCaseProvider = Provider<GetCategories>((ref) {
  return GetCategories(ref.read(categoriesRepositoryProvider));
});

final updateCategoryUseCaseProvider = Provider<UpdateCategory>((ref) {
  return UpdateCategory(ref.read(categoriesRepositoryProvider));
});

final createCategoryUseCaseProvider = Provider<CreateCategory>((ref) {
  return CreateCategory(ref.read(categoriesRepositoryProvider));
});

final deleteCategoryUseCaseProvider = Provider<DeleteCategory>((ref) {
  return DeleteCategory(ref.read(categoriesRepositoryProvider));
});
