import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/purchases/purchases_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/purchase_order_model.dart';
import 'package:control_stock_web_admin/data/responses/purchase_response.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:control_stock_web_admin/utils/logger.dart';
import 'package:dartz/dartz.dart';

class PurchasesRepositoryImplementation implements PurchasesRepository {
  final PurchasesRemoteDataSource purchasesRemoteDataSource;

  PurchasesRepositoryImplementation(this.purchasesRemoteDataSource);

  @override
  Future<Either<Failure, void>> delete(int customerId, int recordId) async {
    try {
      await purchasesRemoteDataSource.delete(customerId, recordId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Purchase>>> getAll() async {
    try {
      List<PurchaseResponse> response = await purchasesRemoteDataSource.getAll();
      final purchases = response.map<Purchase>((e) => e.toDomain()).toList();
      return Right(purchases);
    } catch (e) {
      logger.e(e);

      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Purchase>>> getByCustomerId(int customerId) {
    // TODO: implement getByCustomerId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> purchaseOrder(PurchaseOrder purchaseOrder) async {
    try {
      PurchaseOrderModel model = purchaseOrder.toModel();
      await purchasesRemoteDataSource.createPurchase(purchaseOrder.customer!.id!, model);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
