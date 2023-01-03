import 'dart:io';

import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';

import 'logger.dart';

main() {
  setUp(() {
    TestLogger.record();
  });

  test('TestEndpointErrorConfig', () {
    Matcher matcher;
    String indexFile;
    String basePath = "example/errors/endpoint";

    matcher = throwsA(isA<ErrorEndpointIndexFileIsEmpty>());
    indexFile = "$basePath/empty-index/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    matcher = throwsA(isA<ErrorEndpointExpectedYamlMap>());
    indexFile = "$basePath/not-yaml-map/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    matcher = throwsA(isA<ErrorEndpointResponseIsUndefined>());
    indexFile = "$basePath/not-response/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    matcher = throwsA(isA<ErrorEndpointResponseFileNotFound>());
    indexFile = "$basePath/response-data-404/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    indexFile = "example/endpoint/index.yaml";
    final endpoint = Endpoint(endpointFile: File(indexFile));
    expect(endpoint.getResponseWriter(), isNotNull);

    // expect a non-null resposeWriter
  });
}

/*
yaml will handle its own errors

how do we handle bad yaml, for now it is a system failure
as it is the only endpoint file available
*/
