import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/login/data/models/user_credentitials_model.dart';
import 'package:sss_mobile/features/login/domain/entities/token.dart';

abstract class UserRepository {
  Future<Either<Failure, Token>> authenticate(UserCredentialsModel credentials);

  Either<Failure, String> accessToken();
  String accessTokenForImage();

  Future<Either<Failure, String>> persistToken(String token);

  Future<Either<Failure, dynamic>> deleteToken();

  bool hasToken();
}
