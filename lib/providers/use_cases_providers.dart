// Products
import 'package:control_stock_web_admin/domain/use_cases/auth/exchange_token.dart';
import 'package:control_stock_web_admin/domain/use_cases/auth/sign_in_with_crendetials.dart';
import 'package:control_stock_web_admin/domain/use_cases/auth/sign_in_with_email_link.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/create_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/delete_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/get_categories.dart';
import 'package:control_stock_web_admin/domain/use_cases/categories/update_category.dart';
import 'package:control_stock_web_admin/domain/use_cases/customers/create_customer.dart';
import 'package:control_stock_web_admin/domain/use_cases/customers/delete_customer.dart';
import 'package:control_stock_web_admin/domain/use_cases/customers/get_customers.dart';
import 'package:control_stock_web_admin/domain/use_cases/customers/update_customer.dart';
import 'package:control_stock_web_admin/domain/use_cases/commerce/get_commerce_by_id.dart';
import 'package:control_stock_web_admin/domain/use_cases/commerce/update_commerce.dart';
import 'package:control_stock_web_admin/domain/use_cases/payment_methods/create_payment_method.dart';
import 'package:control_stock_web_admin/domain/use_cases/payment_methods/delete_payment_method.dart';
import 'package:control_stock_web_admin/domain/use_cases/payment_methods/get_payment_methods.dart';
import 'package:control_stock_web_admin/domain/use_cases/payment_methods/update_payment_method.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/create_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/create_products.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/delete_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/get_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/get_products.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/update_product.dart';
import 'package:control_stock_web_admin/domain/use_cases/products/update_products.dart';
import 'package:control_stock_web_admin/domain/use_cases/purchases/confirm_purchase.dart';
import 'package:control_stock_web_admin/domain/use_cases/purchases/delete_purchase.dart';
import 'package:control_stock_web_admin/domain/use_cases/purchases/get_purchases.dart';
import 'package:control_stock_web_admin/domain/use_cases/purchases/modify_products_in_purchase.dart';
import 'package:control_stock_web_admin/domain/use_cases/purchases/modify_purchase_status.dart';
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

final updateProductsUseCaseProvider = Provider<UpdateProducts>((ref) {
  return UpdateProducts(ref.read(productsRepositoryProvider));
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

final updateCommerceUseCaseProvider = Provider<UpdateCommerce>((ref) {
  return UpdateCommerce(ref.read(commerceRepositoryProvider));
});

// --------------------//
// ---- Customers ---- //
// --------------------//
final getCustomersUseCaseProvider = Provider<GetCustomers>((ref) {
  return GetCustomers(ref.read(customersRepositoryProvider));
});

final updateCustomerUseCaseProvider = Provider<UpdateCustomer>((ref) {
  return UpdateCustomer(ref.read(customersRepositoryProvider));
});

final createCustomerUseCaseProvider = Provider<CreateCustomer>((ref) {
  return CreateCustomer(ref.read(customersRepositoryProvider));
});

final deleteCustomerUseCaseProvider = Provider<DeleteCustomer>((ref) {
  return DeleteCustomer(ref.read(customersRepositoryProvider));
});

// ----------------------------//
// -------- Purchases  -------- //
// ----------------------------//
final getPurchasesUseCaseProvider = Provider<GetPurchases>((ref) {
  return GetPurchases(ref.read(purchasesRepositoryProvider));
});

final confirmPurchaseUseCaseProvider = Provider<ConfirmPurchaseOrder>((ref) {
  return ConfirmPurchaseOrder(ref.read(purchasesRepositoryProvider));
});

final deletePurchaseUseCaseProvider = Provider<DeletePurchase>((ref) {
  return DeletePurchase(ref.read(purchasesRepositoryProvider));
});

final modifyStatusPurchaseUseCaseProvider = Provider<ModifyStatusPurchaseOrder>((ref) {
  return ModifyStatusPurchaseOrder(ref.read(purchasesRepositoryProvider));
});

final modifyProductsInPurchaseUseCaseProvider = Provider<ModifyProductsInPurchaseUseCase>((ref) {
  return ModifyProductsInPurchaseUseCase(ref.read(purchasesRepositoryProvider));
});

// ----------------------------//
// ----- Payment methods ----- //
// ----------------------------//
final getPaymentMethodsUseCaseProvider = Provider<GetPaymentMethods>((ref) {
  return GetPaymentMethods(ref.read(paymentMethodsRepositoryProvider));
});

final deletePaymentMethodUseCaseProvider = Provider<DeletePaymentMethod>((ref) {
  return DeletePaymentMethod(ref.read(paymentMethodsRepositoryProvider));
});

final createPaymentMethodUseCaseProvider = Provider<CreatePaymentMethod>((ref) {
  return CreatePaymentMethod(ref.read(paymentMethodsRepositoryProvider));
});

final updatePaymentMethodUseCaseProvider = Provider<UpdatePaymentMethod>((ref) {
  return UpdatePaymentMethod(ref.read(paymentMethodsRepositoryProvider));
});
