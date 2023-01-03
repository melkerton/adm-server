// dart
import 'dart:io';

// package

import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:xperi_dart_mock/endpoint.dart';

import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/sources.dart';

// local

main() {
  bool haveLog = false;
  setUp(() {});

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
