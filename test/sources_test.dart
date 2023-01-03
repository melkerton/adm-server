// dart
import 'dart:io';

// package

import 'package:test/test.dart';

import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/sources.dart';

import 'logger.dart';

// local

main() {
  setUp(() {
    TestLogger.record();
  });

  test('SourcesDirNotFound', () {
    final Matcher throwsError = throwsA(isA<ErrorSourcesDirNotFound>());

    String sourcesDir;

    sourcesDir = "example/errors/sources/do-not-create";
    expect(() => Sources.connect(sourcesDir), throwsError);

    // getEndpoint
  });

  test('SourcesErrorSourcesEndpointFileNotFound', () {
    final Matcher throwsError =
        throwsA(isA<ErrorSourcesEndpointFileNotFound>());

    String sourcesDir;

    sourcesDir = "example/errors/sources/no-endpoint-file";
    final sources = Sources.connect(sourcesDir);
    expect(() => sources.getEndpoint(), throwsError);

    // getEndpoint
  });
}

// [1] https://pub.dev/documentation/test_api/latest/expect/throwsA.html
/// need to come back to this
