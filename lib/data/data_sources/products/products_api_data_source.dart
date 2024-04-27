import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/products/products_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/product_model.dart';
import 'package:control_stock_web_admin/data/responses/product_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class ProductsApiDataSource implements ProductsRemoteDataSource {
  final APIClient apiClient;

  ProductsApiDataSource(this.apiClient);

  String path = '/commerces/1/products';

  @override
  Future<Either<AppError, ProductResponse>> add(ProductModel product) async {
    final body = product.toCreateProductJson();
    final response = await apiClient.sendPost(path, body: body);
    return response.fold(
      (l) => Left(l),
      (r) => Right(ProductResponse.fromJson(r)),
    );
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await apiClient.sendDelete('$path/$id');
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, List<ProductResponse>>> getAll() async {
    final response = await apiClient.sendGet(path);
    return response.fold((l) => Left(l), (r) {
      final products = r.map<ProductResponse>((e) => ProductResponse.fromJson(e)).toList();
      return Right(products);
    });
  }

  @override
  Future<Either<AppError, ProductResponse>> update(ProductModel product) async {
    final body = product.toUpdateProductJson();
    final response = await apiClient.sendPut('$path/${product.id}', body: body);
    return response.fold(
      (l) => Left(l),
      (r) => Right(ProductResponse.fromJson(r)),
    );
  }

  @override
  Future<Either<AppError, void>> addProducts(List<ProductModel> products) async {
    final body = {
      'products': products.map((e) => e.toCreateProductJson()).toList(),
    };
    final response = await apiClient.sendPost('$path/bulk', body: body);
    return response.fold((l) => Left(AppError.handle(l.code)), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> updateProducts(List<ProductModel> products) async {
    final body = {
      'products': products.map((e) => e.toUpdateProductJson()).toList(),
    };
    final response = await apiClient.sendPatch('$path/bulk', body: body);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
