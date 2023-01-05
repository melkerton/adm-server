import 'dart:io';

import 'package:test/test.dart';
import 'package:adm_server/endpoint.dart';

import 'logger.dart';

main() {
  setUp(() {
    TestLogger.record();
  });

  test('TestEndpointGetResponseWriter', () {
    String indexFile;
    Endpoint endpoint;

    // valid responseWriter found
    indexFile = "example/index.yaml";
    endpoint = Endpoint(endpointFile: File(indexFile));
    expect(endpoint.getResponseWriter("/alpha"), isNotNull);
  });
}
