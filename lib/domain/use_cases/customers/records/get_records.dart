import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer_record.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class GetCustomerRecords {
  final CustomersRepository _repository;

  GetCustomerRecords(this._repository);

  Future<Either<Failure, List<CustomerRecord>>> execute(int customerId) async {
    return await _repository.getRecords(customerId);
  }
}
