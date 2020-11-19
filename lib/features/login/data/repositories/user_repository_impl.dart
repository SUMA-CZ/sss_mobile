import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/login/data/datasources/account_datasource.dart';
import 'package:sss_mobile/features/login/domain/entities/token.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

const SP_ACCESS_TOKEN = 'TOKEN';

class UserRepositoryImpl extends UserRepository {
  final SharedPreferences prefs;
  final AccountDataSource dataSource;

  UserRepositoryImpl({@required this.prefs, @required this.dataSource})
      : assert(prefs != null, dataSource != null);

  @override
  Either<Failure, String> accessToken() {
    var token = prefs.getString(SP_ACCESS_TOKEN);
    if (token != null) {
      return Right(token);
    } else {
      return Left(SharedPreferencesFailure());
    }
  }

  String accessTokenForImage() {
    return prefs.getString(SP_ACCESS_TOKEN);
  }

  @override
  Future<Either<Failure, dynamic>> deleteToken() async {
    if (await prefs.remove(SP_ACCESS_TOKEN)) {
      return Right(null);
    } else {
      return Left(SharedPreferencesFailure());
    }
  }

  @override
  bool hasToken() {
    var token = (prefs.getString(SP_ACCESS_TOKEN));
    return token != null;
  }

  @override
  Future<Either<Failure, String>> persistToken(String token) async {
    try {
      final saved = await prefs.setString(SP_ACCESS_TOKEN, token);
      if (saved) {
        return Right(token);
      } else {
        return Left(SharedPreferencesFailure());
      }
    } catch (e) {
      return Left(SharedPreferencesFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> authenticate(credentials) async {
    try {
      final model = await dataSource.authenticate(credentials);
      await persistToken(model.accessToken);
      return Right(model);
    } catch (e) {
      await deleteToken();
      return Left(FailureAuthentication());
    }
  }
}
