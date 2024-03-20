import 'package:control_stock_web_admin/data/responses/product_response.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductResponse>> getAll();
  Future<ProductResponse> add(ProductResponse product);
  Future<ProductResponse> update(ProductResponse product);
  Future<void> delete(String id);
}
