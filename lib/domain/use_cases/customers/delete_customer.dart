import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCustomer {
  final CustomersRepository _repository;

  DeleteCustomer(this._repository);

  Future<Either<Failure, void>> execute(int id) async {
    return await _repository.delete(id);
  }
}
