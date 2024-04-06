import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/domain/repositories/clients_repository.dart';
import 'package:dartz/dartz.dart';

class CreateClient {
  final ClientsRepository _repository;

  CreateClient(this._repository);

  Future<Either<Failure, Client>> execute(Client client) async {
    return await _repository.create(client);
  }
}
