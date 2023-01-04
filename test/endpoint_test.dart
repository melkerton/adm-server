import 'dart:io';

import 'package:test/test.dart';
import 'package:adm_server/endpoint.dart';
import 'package:adm_server/error.dart';

import 'logger.dart';

main() {
  setUp(() {
    TestLogger.record();
  });

  test('TestEndpointErrorConstructorError', () {
    Matcher matcher;
    String indexFile;
    String basePath = "example/errors/endpoint";

    matcher = throwsA(isA<ErrorEndpointExpectedYamlList>());
    indexFile = "$basePath/not-yaml-list/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    // expect a non-null resposeWriter
  });

  test('TestEndpointGetResponseWriter', () {
    Matcher matcher;
    String indexFile;
    Endpoint endpoint;
    String basePath = "example/errors/endpoint";

    // no response for matched path
    matcher = throwsA(isA<ErrorEndpointResponseIsUndefined>());
    indexFile = "$basePath/not-response/index.yaml";
    endpoint = Endpoint(endpointFile: File(indexFile));
    expect(() => endpoint.getResponseWriter("/alpha"), matcher);

    // responseFile not found
    matcher = throwsA(isA<ErrorEndpointResponseFileNotFound>());
    indexFile = "$basePath/response-data-404/index.yaml";
    endpoint = Endpoint(endpointFile: File(indexFile));
    expect(() => endpoint.getResponseWriter("/alpha"), matcher);

    // valid responseWriter found
    indexFile = "example/endpoint/index.yaml";
    endpoint = Endpoint(endpointFile: File(indexFile));
    expect(endpoint.getResponseWriter("/alpha"), isNotNull);
  });
}
