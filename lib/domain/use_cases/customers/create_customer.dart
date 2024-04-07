import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCustomer {
  final CustomersRepository _repository;

  CreateCustomer(this._repository);

  Future<Either<Failure, Customer>> execute(Customer customer) async {
    return await _repository.create(customer);
  }
}
