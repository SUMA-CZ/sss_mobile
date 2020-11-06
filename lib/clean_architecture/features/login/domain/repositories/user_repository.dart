import 'package:dartz/dartz.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';

abstract class UserRepository {
  Either<Failure, String> accessToken();

  Future<Either<Failure, String>> persistToken(String token);

  Future<Either<Failure, dynamic>> deleteToken();

  bool hasToken();
}
