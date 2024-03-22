import 'package:control_stock_web_admin/data/data_sources/products_remote_data_source.dart';
import 'package:control_stock_web_admin/data/responses/product_response.dart';
import 'package:control_stock_web_admin/data/utils/constants.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class ProductsApiDataSource implements ProductsRemoteDataSource {
  final APIClient apiClient;

  ProductsApiDataSource(this.apiClient);

  @override
  Future<ProductResponse> add(Product product) async {
    try {
      final response = await apiClient.sendPost(pathProducts, body: product.toJson());
      final productResponse = ProductResponse.fromJson(response);
      return productResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      return await apiClient.sendDelete('$pathProducts/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductResponse>> getAll() async {
    try {
      final response = await apiClient.sendGet(pathProducts);
      final productResponse = response.map<ProductResponse>((e) => ProductResponse.fromJson(e)).toList();
      return productResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> update(Product product) async {
    try {
      final response = await apiClient.sendPut('$pathProducts/${product.id}', body: product.toJson());
      final productResponse = ProductResponse.fromJson(response);
      return productResponse;
    } catch (e) {
      rethrow;
    }
  }
}
