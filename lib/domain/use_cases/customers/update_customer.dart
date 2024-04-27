import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateCustomer {
  final CustomersRepository repository;

  UpdateCustomer(this.repository);

  Future<Either<AppError, void>> execute(Customer customer) async {
    return await repository.update(customer);
  }
}
