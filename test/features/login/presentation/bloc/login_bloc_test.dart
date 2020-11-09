import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/authorization/auth.dart';
import 'package:sss_mobile/core/authorization/auth_bloc.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/features/login/domain/entities/e_token.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';
import 'package:sss_mobile/features/login/domain/usecases/authenticate.dart';
import 'package:sss_mobile/features/login/presentation/bloc/login.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  MockUserRepository mockUserRepository;

  Authenticate authenticate;
  AuthenticationBloc authenticateBloc;
  LoginBloc loginBloc;

  setUp(() {
    mockUserRepository = MockUserRepository();
    authenticate = Authenticate(mockUserRepository);
    authenticateBloc = AuthenticationBloc(userRepository: mockUserRepository);
    loginBloc = LoginBloc(authenticate: authenticate, authenticationBloc: authenticateBloc);
  });

  final tToken = EToken(accessToken: 'access-token');
  final tCreds = EUserCredentialsModel(password: 'passwd', username: 'user');

  test('should get data from usecase', () async {
    when(mockUserRepository.authenticate(tCreds)).thenAnswer((_) async => Right(tToken));

    loginBloc.add(LoginButtonPressed(username: 'user', password: 'passwd'));

    final result = await authenticate(tCreds);
    // assert
    expect(result, Right(tToken));
  });

  test(
      'should [Loading, (authbloc.LoggedIn) => [AuthenticationLoading,'
      ' AuthenticationAuthenticated], Initial] when login is success', () async {
    // arrange
    when(authenticate.call(any)).thenAnswer((_) async => Right(tToken));

    final expectedForLoginBloc = [LoginLoading(), LoginInitial()];
    final expectedForAuthBloc = [AuthenticationLoading(), AuthenticationAuthenticated()];

    //act
    loginBloc.add(LoginButtonPressed(username: 'user', password: 'passwd'));
    final result = await authenticate(tCreds);

    // assert
    expectLater(loginBloc, emitsInOrder(expectedForLoginBloc)).timeout(Duration(seconds: 2));
    expectLater(authenticateBloc, emitsInOrder(expectedForAuthBloc)).timeout(Duration(seconds: 2));
    expect(result, Right(tToken));
  });

  test(
      'should [Loading, (authbloc.LoggedIn) => [AuthenticationLoading,'
      ' AuthenticationUnAuhtorized], LoginFailure] when login is success', () async {
    // arrange
    when(authenticate.call(any)).thenAnswer((_) async => Left(FailureAuthentication()));

    final expectedForLoginBloc = [LoginLoading(), LoginFailure(error: 'Authentication Failed')];
    final expectedForAuthBloc = [AuthenticationLoading(), AuthenticationUnauthenticated()];

    //act
    loginBloc.add(LoginButtonPressed(username: 'user', password: 'passwd'));
    final result = await authenticate(tCreds);

    // assert
    expectLater(loginBloc, emitsInOrder(expectedForLoginBloc)).timeout(Duration(seconds: 2));
    expectLater(authenticateBloc, emitsInOrder(expectedForAuthBloc)).timeout(Duration(seconds: 2));
    expect(result, Left(FailureAuthentication()));
  });
}
