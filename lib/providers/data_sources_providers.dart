import 'package:control_stock_web_admin/data/data_sources/categories_api_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/products_api_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/products_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/users_share_preferences.dart';
import 'package:control_stock_web_admin/infraestructure/api_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersLocalDataSources = Provider((ref) => UsersSharePreferences());
final productsDataSourcesProviders =
    Provider<ProductsRemoteDataSource>((ref) => ProductsApiDataSource(ref.read(apiClientProvider)));
final categoriesDataSourcesProviders =
    Provider<CategoriesRemoteDataSource>((ref) => CategoriesApiDataSource(ref.read(apiClientProvider)));
