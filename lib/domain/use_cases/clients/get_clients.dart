import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/domain/repositories/clients_repository.dart';
import 'package:dartz/dartz.dart';

class GetClients {
  final ClientsRepository _repository;

  GetClients(this._repository);

  Future<Either<Failure, List<Client>>> execute() async {
    return await _repository.getAll();
  }
}
