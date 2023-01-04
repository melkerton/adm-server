// dart
import 'dart:io';

// package

import 'package:test/test.dart';

import 'package:adm_server/error.dart';
import 'package:adm_server/sources.dart';

import 'logger.dart';

// local

// we don't throw errors anymore, we report and continue
main() {
  setUp(() {
    TestLogger.record();
  });

  test('SourcesDirNotFound', () {
    final Matcher throwsError = throwsA(isA<ErrorSourcesDirNotFound>());

    String sourcesDir;

    sourcesDir = "example/errors/sources/do-not-create";
    // should not error
    // getEndpoint
  });

  /*
  test('SourcesErrorSourcesEndpointFileNotFound', () {
    final Matcher throwsError =
        throwsA(isA<ErrorSourcesEndpointFileNotFound>());

    String sourcesDir;

    sourcesDir = "example/errors/sources/no-endpoint-file";
    final sources = Sources.connect(sourcesDir);
    expect(() => sources.getEndpoint(), throwsError);
  });

  test('TestSourcesGetEndpointNotNull', () {
    String sourcesDir = "example/endpoint";
    final sources = Sources.connect(sourcesDir);
    sources.getEndpoint();
    expect(sources.getEndpoint(), isNotNull);
  });
  */
}

// [1] https://pub.dev/documentation/test_api/latest/expect/throwsA.html
/// need to come back to this
