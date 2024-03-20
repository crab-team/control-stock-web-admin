import 'package:control_stock_web_admin/data/data_sources/categories_mongodb.dart';
import 'package:control_stock_web_admin/data/data_sources/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/data/data_sources/products_mongodb.dart';
import 'package:control_stock_web_admin/data/data_sources/products_remote_data_source.dart';
import 'package:control_stock_web_admin/infraestructure/mongo_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsDataSourcesProviders = Provider<ProductsRemoteDataSource>((ref) => );
final categoriesDataSourcesProviders =
    Provider<CategoriesRemoteDataSource>((ref) => );
