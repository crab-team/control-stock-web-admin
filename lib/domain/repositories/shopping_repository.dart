import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:dartz/dartz.dart';

abstract class PurchasesRepository {
  Future<Either<Failure, List<Purchase>>> getAll();
  Future<Either<Failure, void>> purchaseProducts(int customerId, PurchaseProducts purchaseProducts);
  Future<Either<Failure, void>> deletePurchase(int recordId);
  Future<Either<Failure, List<Purchase>>> getByCustomerId(int customerId);
}
