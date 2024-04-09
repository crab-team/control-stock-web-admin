import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/customer_record.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCustomerRecords {
  final CustomersRepository _customersRepository;

  CreateCustomerRecords(this._customersRepository);

  Future<Either<Failure, List<CustomerRecord>>> execute(int customerId, List<CustomerRecord> records) async {
    return _customersRepository.createRecords(customerId, records);
  }
}
