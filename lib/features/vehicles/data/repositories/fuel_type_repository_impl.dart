import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/fuel_types_datasource.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/fuel_type_repository.dart';

class FuelTypeRepositoryImpl extends FuelTypeRepository {
  final FuelTypesDataSource remoteDataSource;

  FuelTypeRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FuelType>>> readAll() async {
    try {
      final fuelTypes = await remoteDataSource.getAll();
      return Right(fuelTypes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
