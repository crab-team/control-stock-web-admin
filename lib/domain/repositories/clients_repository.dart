import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:dartz/dartz.dart';

abstract class ClientsRepository {
  Future<Either<Failure, Client>> create(Client client);
  Future<Either<Failure, void>> update(Client client);
  Future<Either<Failure, void>> delete(int id);
  Future<Either<Failure, List<Client>>> getAll();
}
