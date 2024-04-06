import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/clients/clients_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/domain/repositories/clients_repository.dart';
import 'package:dartz/dartz.dart';

class ClientsRepositoryImplementation implements ClientsRepository {
  final ClientsRemoteDataSource remoteDataSource;

  ClientsRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, Client>> create(Client newClient) async {
    try {
      final clientParams = newClient.toModel();
      final response = await remoteDataSource.addClient(clientParams);
      final client = response.toDomain();
      return Right(client);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      await remoteDataSource.deleteClient(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Client>>> getAll() async {
    try {
      final response = await remoteDataSource.getClients();
      final clients = response.map((e) => e.toDomain()).toList();
      return Right(clients);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(Client client) async {
    try {
      final clientParams = client.toModel();
      await remoteDataSource.updateClient(clientParams);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
