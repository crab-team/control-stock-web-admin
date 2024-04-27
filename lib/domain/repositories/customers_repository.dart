import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomersRepository {
  Future<Either<AppError, Customer>> create(Customer client);
  Future<Either<AppError, void>> update(Customer client);
  Future<Either<AppError, void>> delete(int id);
  Future<Either<AppError, List<Customer>>> getAll();
}
