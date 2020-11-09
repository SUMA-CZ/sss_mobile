import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/login/data/models/e_token_model.dart';
import 'package:sss_mobile/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';
import 'package:sss_mobile/features/login/domain/usecases/authenticate.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  Authenticate usecase;
  MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    usecase = Authenticate(repository);
  });

  var tToken = ETokenModel.fromJson(jsonDecode(fixture('account.json')));
  var creds = EUserCredentialsModel(password: 'a', username: 'b');

  test(
    'should Authenticate',
    () async {
      // arrange
      when(repository.authenticate(any)).thenAnswer((_) async => Right(tToken));
      // act
      final result = await usecase(creds);
      // assert
      expect(result, Right(tToken));
      verify(repository.authenticate(creds));
      verifyNoMoreInteractions(repository);
    },
  );
}
