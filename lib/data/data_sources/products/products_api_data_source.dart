import 'package:control_stock_web_admin/data/data_sources/products/products_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/product_model.dart';
import 'package:control_stock_web_admin/data/responses/product_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:control_stock_web_admin/utils/logger.dart';

class ProductsApiDataSource implements ProductsRemoteDataSource {
  final APIClient apiClient;

  ProductsApiDataSource(this.apiClient);

  String path = '/commerces/1/products';

  @override
  Future<ProductResponse> add(ProductModel product) async {
    try {
      final body = product.toCreateProductJson();
      final response = await apiClient.sendPost(path, body: body);
      final productResponse = ProductResponse.fromJson(response);
      return productResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      return await apiClient.sendDelete('$path/$id');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<ProductResponse>> getAll() async {
    try {
      final response = await apiClient.sendGet(path);
      return response.map<ProductResponse>((e) => ProductResponse.fromJson(e)).toList();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ProductResponse> update(ProductModel product) async {
    try {
      final body = product.toUpdateProductJson();
      final response = await apiClient.sendPut('$path/${product.id}', body: body);
      final productResponse = ProductResponse.fromJson(response);
      return productResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> addProducts(List<ProductModel> products) async {
    try {
      final body = {
        'products': products.map((e) => e.toCreateProductJson()).toList(),
      };
      return await apiClient.sendPost('$path/bulk', body: body);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> updateProducts(List<ProductModel> products) {
    try {
      final body = {
        'products': products.map((e) => e.toUpdateProductJson()).toList(),
      };
      return apiClient.sendPatch('$path/bulk', body: body);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
