import 'package:control_stock_web_admin/data/data_sources/categories/categories_api_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/categories/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/customers/customers_api_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/customers/customers_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_api_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/products/products_api_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/products/products_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/users/users_share_preferences.dart';
import 'package:control_stock_web_admin/infraestructure/api_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersLocalDataSources = Provider((ref) => UsersSharePreferences());
final productsRemoteDataSourcesProvider =
    Provider<ProductsRemoteDataSource>((ref) => ProductsApiDataSource(ref.read(apiClientProvider)));
final categoriesRemoteDataSourcesProvider =
    Provider<CategoriesRemoteDataSource>((ref) => CategoriesApiDataSource(ref.read(apiClientProvider)));
final commerceRemoteDataSourcesProvider =
    Provider<CommerceRemoteDataSource>((ref) => CommerceApiDataSource(ref.read(apiClientProvider)));
final customersRemoteDataSourcesProvider =
    Provider<CustomersRemoteDataSource>((ref) => CustomersApiDataSource(ref.read(apiClientProvider)));
