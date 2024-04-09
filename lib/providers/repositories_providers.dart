import 'package:control_stock_web_admin/data/repositories/auth_repository_implementation.dart';
import 'package:control_stock_web_admin/data/repositories/categories_repository_implementation.dart';
import 'package:control_stock_web_admin/data/repositories/customers_repository_implementation.dart';
import 'package:control_stock_web_admin/data/repositories/commerce_repository_implementation.dart';
import 'package:control_stock_web_admin/data/repositories/payment_methods_repository_implementation.dart';
import 'package:control_stock_web_admin/data/repositories/products_repository_implementation.dart';
import 'package:control_stock_web_admin/data/repositories/users_repository_implementation.dart';
import 'package:control_stock_web_admin/infraestructure/api_client_provider.dart';
import 'package:control_stock_web_admin/providers/data_sources_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImplementation(ref.read(apiClientProvider)));
final usersRepositoryProvider = Provider((ref) => UsersRepositoryImplementation(
      localDataSource: ref.read(usersLocalDataSources),
    ));
final productsRepositoryProvider =
    Provider((ref) => ProductsRepositoryImplementation(ref.read(productsRemoteDataSourcesProvider)));
final categoriesRepositoryProvider =
    Provider((ref) => CategoriesRepositoryImplementation(ref.read(categoriesRemoteDataSourcesProvider)));
final commerceRepositoryProvider =
    Provider((ref) => CommerceRepositoryImplementation(ref.read(commerceRemoteDataSourcesProvider)));
final customersRepositoryProvider =
    Provider((ref) => CustomersRepositoryImplementation(ref.read(customersRemoteDataSourcesProvider)));
final paymentMethodsRepositoryProvider =
    Provider((ref) => PaymentMethodsRepositoryImplementation(ref.read(paymentMethodsRemoteDataSourcesProvider)));
