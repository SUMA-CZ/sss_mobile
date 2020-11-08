import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/login/domain/entities/e_token.dart';
import 'package:sss_mobile/features/login/domain/entities/e_user_credentials.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

class Authenticate implements UseCase<EToken, UserCredentials> {
  final UserRepository repository;

  Authenticate(this.repository);

  Future<Either<Failure, EToken>> call(UserCredentials creds) async {
    return await repository.authenticate(creds);
  }
}
