import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/purchases/purchases_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/purchase_products_model.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:fpdart/fpdart.dart';

class PurchasesRepositoryImplementation implements PurchasesRepository {
  final PurchasesRemoteDataSource purchasesRemoteDataSource;

  PurchasesRepositoryImplementation(this.purchasesRemoteDataSource);

  @override
  Future<Either<AppError, void>> delete(int customerId, int purchaseId) async {
    final response = await purchasesRemoteDataSource.delete(customerId, purchaseId);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, List<Purchase>>> getAll() async {
    final response = await purchasesRemoteDataSource.getAll();
    return response.fold((l) => Left(l), (r) {
      final purchases = r.map<Purchase>((e) => e.toDomain()).toList();
      return Right(purchases);
    });
  }

  @override
  Future<Either<AppError, List<Purchase>>> getByCustomerId(int customerId) {
    // TODO: implement getByCustomerId
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, void>> confirmPurchase(Purchase purchase) async {
    final model = purchase.toConfirmPurchase();
    print('model $model');
    final response = await purchasesRemoteDataSource.createPurchase(purchase.customer!.id!, model);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> modifyStatus(int customerId, int purchaseId, PurchaseStatus purchaseStatus) async {
    final response = await purchasesRemoteDataSource.modifyStatus(customerId, purchaseId, purchaseStatus.string);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> modifyProductsInPurchase(
      int commerceId, int customerId, int purchaseId, List<PurchaseProduct> products) async {
    final List<PurchaseProductModel> productsModel = products.map((e) => e.toModel()).toList();
    final response =
        await purchasesRemoteDataSource.modifyProductsInPurchase(commerceId, customerId, purchaseId, productsModel);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
