import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/clients_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteClient {
  final ClientsRepository _repository;

  DeleteClient(this._repository);

  Future<Either<Failure, void>> execute(int id) async {
    return await _repository.delete(id);
  }
}
