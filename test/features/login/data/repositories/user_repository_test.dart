import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/repositories/user_repository_impl.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/repositories/user_repository.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserRepository repo;
  MockSharedPreferences mockSharedPreferences;

  setUp(() async {
    mockSharedPreferences = MockSharedPreferences();
    repo = UserRepositoryImpl(prefs: mockSharedPreferences);
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
    'should return Failure when there is not a cached value',
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
}
