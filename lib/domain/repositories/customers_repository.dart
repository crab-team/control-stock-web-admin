import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:dartz/dartz.dart';

abstract class CustomersRepository {
  Future<Either<Failure, Customer>> create(Customer client);
  Future<Either<Failure, void>> update(Customer client);
  Future<Either<Failure, void>> delete(int id);
  Future<Either<Failure, List<Customer>>> getAll();
}
