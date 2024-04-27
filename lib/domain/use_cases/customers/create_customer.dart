import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateCustomer {
  final CustomersRepository _repository;

  CreateCustomer(this._repository);

  Future<Either<AppError, Customer>> execute(Customer customer) async {
    return await _repository.create(customer);
  }
}
