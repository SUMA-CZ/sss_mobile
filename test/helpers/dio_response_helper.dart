import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';

void setHTTPResponse(HttpClientAdapter dio, int code, String filename) {
  var responsePayload = '';
  if (filename != null) {
    responsePayload = fixture(filename);
  }
  final httpResponse = ResponseBody.fromString(
    responsePayload,
    code,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  when(dio.fetch(any, any, any)).thenAnswer((_) async => httpResponse);
}
