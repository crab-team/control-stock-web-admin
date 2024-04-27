import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/customers/customers_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/repositories/customers_repository.dart';
import 'package:fpdart/fpdart.dart';

class CustomersRepositoryImplementation implements CustomersRepository {
  final CustomersRemoteDataSource remoteDataSource;

  CustomersRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<AppError, Customer>> create(Customer newCustomer) async {
    final customerParams = newCustomer.toModel();
    final response = await remoteDataSource.add(customerParams);
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toDomain()),
    );
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await remoteDataSource.delete(id);
    return response.fold(
      (l) => Left(l),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<AppError, List<Customer>>> getAll() async {
    final response = await remoteDataSource.getAll();
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.map((e) => e.toDomain()).toList()),
    );
  }

  @override
  Future<Either<AppError, void>> update(Customer customer) async {
    final customerParams = customer.toModel();
    final response = await remoteDataSource.update(customerParams);
    return response.fold(
      (l) => Left(l),
      (r) => const Right(null),
    );
  }
}
