import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/customers/customers_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:dartz/dartz.dart';

class CustomersRepositoryImplementation implements CustomersRepository {
  final CustomersRemoteDataSource remoteDataSource;

  CustomersRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, Customer>> create(Customer newCustomer) async {
    try {
      final customerParams = newCustomer.toModel();
      final response = await remoteDataSource.add(customerParams);
      final customer = response.toDomain();
      return Right(customer);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      await remoteDataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Customer>>> getAll() async {
    try {
      final response = await remoteDataSource.getAll();
      final customers = response.map((e) => e.toDomain()).toList();
      return Right(customers);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(Customer customer) async {
    try {
      final customerParams = customer.toModel();
      await remoteDataSource.update(customerParams);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
