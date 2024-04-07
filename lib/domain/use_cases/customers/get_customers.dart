import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class GetCustomers {
  final CustomersRepository _repository;

  GetCustomers(this._repository);

  Future<Either<Failure, List<Customer>>> execute() async {
    return await _repository.getAll();
  }
}
