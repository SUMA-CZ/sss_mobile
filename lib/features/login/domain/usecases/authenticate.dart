import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/login/domain/entities/token.dart';
import 'package:sss_mobile/features/login/domain/entities/user_credentials.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

class Authenticate implements UseCase<Token, UserCredentials> {
  final UserRepository repository;

  Authenticate(this.repository);

  Future<Either<Failure, Token>> call(UserCredentials creds) async {
    return await repository.authenticate(creds);
  }
}
