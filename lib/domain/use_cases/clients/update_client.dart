import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/domain/repositories/clients_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateClient {
  final ClientsRepository repository;

  UpdateClient(this.repository);

  Future<Either<Failure, void>> execute(Client client) async {
    return await repository.update(client);
  }
}
