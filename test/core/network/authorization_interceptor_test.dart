void main() {}

// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http_interceptor/http_methods.dart';
// import 'package:http_interceptor/models/request_data.dart';
// import 'package:mockito/mockito.dart';
// import 'package:sss_mobile/clean_architecture/core/network/authorization_interceptor.dart';
// import 'package:sss_mobile/clean_architecture/features/login/domain/repositories/user_repository.dart';
//
// class MockUserRepository extends Mock implements UserRepository {}
//
// void main() {
//   MockUserRepository mockUserRepository;
//   AuthorizationInterceptor interceptor;
//
//   setUp(() {
//     mockUserRepository = MockUserRepository();
//     interceptor = AuthorizationInterceptor(userRepository: mockUserRepository);
//   });
//
//   test(
//     'should append token to auth header',
//     () async {
//       // arrange
//       final tToken = 'test-token';
//       when(mockUserRepository.accessToken()).thenReturn(Right(tToken));
//       RequestData data =
//           RequestData(method: Method.GET, baseUrl: 'URL', headers: Map<String, String>());
//       // act
//       final result = await interceptor.interceptRequest(data: data);
//       // assert
//       expect(result.headers['Authorization'], 'Bearer $tToken');
//     },
//   );
//
//   test(
//     'should Unauthorized when token not found and making request elsewhere than login',
//     () async {},
//   );
//
//   test(
//     'should Unauthorized when receives 401 from api',
//     () async {},
//   );
// }
