import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/login/data/datasources/account_datasource.dart';
import 'package:sss_mobile/features/login/data/models/e_token_model.dart';
import 'package:sss_mobile/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/features/login/data/repositories/user_repository_impl.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockAccountDataSource extends Mock implements AccountDataSource {}

void main() {
  UserRepository repo;
  MockSharedPreferences mockSharedPreferences;
  MockAccountDataSource mockAccountDataSource;

  setUp(() async {
    mockSharedPreferences = MockSharedPreferences();
    mockAccountDataSource = MockAccountDataSource();
    repo = UserRepositoryImpl(prefs: mockSharedPreferences, dataSource: mockAccountDataSource);
  });

  final tToken = 'token';

  test(
    'should return token from SharedPreferences when there is one saved',
    () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(tToken);
      // act
      final result = repo.accessToken();
      // assert
      verify(mockSharedPreferences.getString(SP_ACCESS_TOKEN));
      expect(result, equals(Right(tToken)));
    },
  );

  test(
    'should return Failure when there is not a cached value',
    () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final result = repo.accessToken();
      final has = repo.hasToken();
      // assert
      verify(mockSharedPreferences.getString(SP_ACCESS_TOKEN));
      expect(result, equals(Left(SharedPreferencesFailure())));
      expect(has, false);
    },
  );

  test(
    'should remove token',
    () async {
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);
      // act
      final result = await repo.deleteToken();
      // assert
      verify(mockSharedPreferences.remove(SP_ACCESS_TOKEN));
      expect(result, Right(null));
    },
  );

  test(
    'should touch setString when persisting token',
    () async {
      // arrange
      when(mockSharedPreferences.setString(SP_ACCESS_TOKEN, any)).thenAnswer((_) async => true);
      // act
      final result = await repo.persistToken('token');
      // assert
      verify(mockSharedPreferences.setString(SP_ACCESS_TOKEN, any));
      expect(result, Right('token'));
    },
  );

  test(
    'should return Failure when there is not a cached value',
    () async {
      // arrange
      when(mockSharedPreferences.setString(SP_ACCESS_TOKEN, any)).thenAnswer((_) async => false);
      // act
      final result = await repo.persistToken('token');
      // assert
      verify(mockSharedPreferences.setString(SP_ACCESS_TOKEN, any));
      expect(result, Left(SharedPreferencesFailure()));
    },
  );

  test(
    'should return token when authentication is 200',
    () async {
      // arrange
      final tTokenModel = ETokenModel(token: 'secret-token');
      final tCreds = EUserCredentialsModel(username: 'null', password: 'null');

      when(mockAccountDataSource.authenticate(any)).thenAnswer((_) async => tTokenModel);
      when(mockSharedPreferences.setString(SP_ACCESS_TOKEN, any)).thenAnswer((_) async => true);
      // act
      final result = await repo.authenticate(tCreds);
      // assert
      verify(mockSharedPreferences.setString(SP_ACCESS_TOKEN, tTokenModel.accessToken));
      expect(result, Right(tTokenModel));
    },
  );

  test(
    'should return saved',
    () async {
      // arrange

      when(mockSharedPreferences.setString(SP_ACCESS_TOKEN, 'token')).thenAnswer((_) async => true);
      when(mockSharedPreferences.getString(SP_ACCESS_TOKEN)).thenReturn('token');
      // act
      await repo.persistToken('token');
      repo.accessToken().fold((l) {
        expect(true, false);
      }, (r) {
        expect(r, 'token');
      });
    },
  );
}
