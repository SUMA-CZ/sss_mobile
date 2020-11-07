import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/authorization/auth.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc bloc;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    bloc = AuthenticationBloc(userRepository: mockUserRepository);
  });

  test(
    'should be uninitialized at the begining',
    () async {
      expect(bloc.state, AuthenticationUninitialized());
    },
  );

  test(
    'should emit [Unauthenticated] when there is no token',
    () async {
      // arrange
      when(mockUserRepository.hasToken()).thenReturn(false);
      // assert later
      final expected = [AuthenticationUnauthenticated()];
      expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2));
      // act
      bloc.add(AppStarted());
    },
  );

  test(
    'should emit [Authenticated] when there is no token',
    () async {
      // arrange
      when(mockUserRepository.hasToken()).thenReturn(true);
      // assert later
      final expected = [AuthenticationAuthenticated()];
      expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2));
      // act
      bloc.add(AppStarted());
    },
  );

  test(
    'should emit [Loading, Authenticated] when loggedIn and save token',
    () async {
      // assert later
      final expected = [AuthenticationLoading(), AuthenticationAuthenticated()];
      expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2));
      // act
      bloc.add(LoggedIn());
      await untilCalled(mockUserRepository.persistToken(any)).timeout(Duration(seconds: 2));
      verify(mockUserRepository.persistToken(any));
    },
  );

  test(
    'should emit [Loading, UnAuthenticated] when logging out and delete token',
    () async {
      // assert later
      final expected = [AuthenticationLoading(), AuthenticationUnauthenticated()];
      expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2));
      // act
      bloc.add(LoggedOut());
      await untilCalled(mockUserRepository.deleteToken()).timeout(Duration(seconds: 2));
      verify(mockUserRepository.deleteToken());
    },
  );
}
