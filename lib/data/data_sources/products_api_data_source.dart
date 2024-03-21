import 'package:control_stock_web_admin/data/data_sources/products_remote_data_source.dart';
import 'package:control_stock_web_admin/data/responses/product_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class ProductsApiDataSource implements ProductsRemoteDataSource {
  final APIClient apiClient;

  ProductsApiDataSource(this.apiClient);

  @override
  Future<ProductResponse> add(ProductResponse product) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ProductResponse>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<ProductResponse> update(ProductResponse product) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
