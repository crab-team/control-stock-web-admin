import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/customer_record.dart';
import 'package:dartz/dartz.dart';

abstract class CustomersRepository {
  Future<Either<Failure, Customer>> create(Customer client);
  Future<Either<Failure, void>> update(Customer client);
  Future<Either<Failure, void>> delete(int id);
  Future<Either<Failure, List<Customer>>> getAll();

  //Records
  Future<Either<Failure, void>> createRecord(int customerId, String record);
  Future<Either<Failure, void>> deleteRecord(int recordId);
  Future<Either<Failure, List<CustomerRecord>>> getRecords(int customerId);
}
