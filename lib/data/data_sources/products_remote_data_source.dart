import 'package:control_stock_web_admin/data/responses/product_response.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductResponse>> getAll();
  Future<ProductResponse> add(Product product);
  Future<ProductResponse> update(Product product);
  Future<void> delete(int id);
}
