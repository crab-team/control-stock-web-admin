import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteCustomer {
  final CustomersRepository _repository;

  DeleteCustomer(this._repository);

  Future<Either<AppError, void>> execute(int id) async {
    return await _repository.delete(id);
  }
}
