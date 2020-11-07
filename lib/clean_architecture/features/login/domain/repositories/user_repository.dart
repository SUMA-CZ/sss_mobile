import 'package:dartz/dartz.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/entities/e_token.dart';

abstract class UserRepository {
  Future<Either<Failure, EToken>> authenticate(EUserCredentialsModel credentials);

  Either<Failure, String> accessToken();

  Future<Either<Failure, String>> persistToken(String token);

  Future<Either<Failure, dynamic>> deleteToken();

  bool hasToken();
}
