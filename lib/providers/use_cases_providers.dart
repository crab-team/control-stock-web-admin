// Products
import 'package:control_stock_web_admin/domain/use_cases/auth/exchange_token.dart';
import 'package:control_stock_web_admin/domain/use_cases/auth/sign_in_with_crendetials.dart';
import 'package:control_stock_web_admin/domain/use_cases/auth/sign_in_with_email_link.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/create_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/delete_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/get_categories.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/update_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/commerce/get_commerce_by_id.dart';
import 'package:control_stock_web_admin/domain/use_cases/commerce/update_cash_payment_percentage.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/create_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/create_products.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/delete_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/get_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/get_products.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/update_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/users/get_user.dart';
import 'package:control_stock_web_admin/domain/use_cases/users/store_user.dart';
import 'package:control_stock_web_admin/providers/repositories_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---------------//
// ---- Auth ---- //
// ---------------//
final signInWitEmailLinkUseCase = Provider<SignInWitEmailLink>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignInWitEmailLink(repository);
});
final signInWithCredentialsUseCase =
    Provider.autoDispose((ref) => SignInWithCredentials(ref.read(authRepositoryProvider)));
final exchangeTokenUseCase = Provider.autoDispose((ref) => ExchangeToken(ref.read(authRepositoryProvider)));

// ----------------//
// ---- Users ---- //
// ----------------//
final getUserUseCase = Provider.autoDispose((ref) => GetUser(ref.read(usersRepositoryProvider)));
final storeUserUseCase = Provider.autoDispose((ref) => StoreUser(ref.read(usersRepositoryProvider)));

// -------------------//
// ---- Products ---- //
// -------------------//
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

final createProductsUseCaseProvider = Provider<CreateProducts>((ref) {
  return CreateProducts(ref.read(productsRepositoryProvider));
});

final deleteProductUseCaseProvider = Provider<DeleteProduct>((ref) {
  return DeleteProduct(ref.read(productsRepositoryProvider));
});

// ---------------------//
// ---- Categories ---- //
// ---------------------//
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

// -------------------//
// ---- Commerce ---- //
// -------------------//
final getCommerceByIdUseCaseProvider = Provider<GetCommerceById>((ref) {
  return GetCommerceById(ref.read(commerceRepositoryProvider));
});
final updateCashPaymentPercentageUseCaseProvider = Provider<UpdateCashPaymentPercentage>((ref) {
  return UpdateCashPaymentPercentage(ref.read(commerceRepositoryProvider));
});
