import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/repositories/user_repository.dart';

const SP_ACCESS_TOKEN = 'SP_ACCESS_TOKEN';

class UserRepositoryImpl extends UserRepository {
  final SharedPreferences prefs;

  UserRepositoryImpl({@required this.prefs}) : assert(prefs != null);

  @override
  Either<Failure, String> accessToken() {
    String token = prefs.getString(SP_ACCESS_TOKEN);
    if (token != null && token != "") {
      return Right(token);
    } else {
      return Left(SharedPreferencesFailure());
    }
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
    String token = (prefs.getString(SP_ACCESS_TOKEN));
    return token != null;
  }

  @override
  Future<Either<Failure, String>> persistToken(String token) async {
    try {
      if (await prefs.setString(SP_ACCESS_TOKEN, token)) {
        return Right(token);
      } else {
        return Left(SharedPreferencesFailure());
      }
    } catch (e) {
      return Left(SharedPreferencesFailure());
    }
  }
}
