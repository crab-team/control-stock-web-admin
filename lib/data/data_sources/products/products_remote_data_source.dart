import 'package:control_stock_web_admin/data/models/product_model.dart';
import 'package:control_stock_web_admin/data/responses/product_response.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductResponse>> getAll();
  Future<ProductResponse> add(ProductModel product);
  Future<void> addProducts(List<ProductModel> products);
  Future<ProductResponse> update(ProductModel product);
  Future<void> updateProducts(List<ProductModel> products);
  Future<void> delete(int id);
}
