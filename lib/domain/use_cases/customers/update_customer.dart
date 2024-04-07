import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCustomer {
  final CustomersRepository repository;

  UpdateCustomer(this.repository);

  Future<Either<Failure, void>> execute(Customer customer) async {
    return await repository.update(customer);
  }
}
