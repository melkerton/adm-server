// dart
import 'dart:io';

// package

import 'package:test/test.dart';
import 'package:xperi_dart_mock/endpoint.dart';

import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/sources.dart';

// local

main() {
  test('SourcesEndpointFile', () {
    //
    Sources sources;
    sources = Sources(sourcesDir: "example/errors/not-really-here");

    // not found
    bool thrown = false;
    try {
      // [1]
      sources.getEndpoint();
    } catch (e) {
      expect(e, isA<ErrorEndpointIndexFileNotFound>());
      thrown = true;
    }

    expect(thrown, isTrue);

    // found
    sources = Sources(sourcesDir: "example/endpoint");
    Endpoint? endpoint = sources.getEndpoint();

    expect(endpoint, isNotNull);
  });

  test('SourcesEndpointDirectory', () {
    // not found
    bool thrown = false;
    try {
      // [1]
      /// review this, check it doesnt exists first? pre
      Sources(sourcesDir: "example/errors/not-really-there");
    } catch (e) {
      expect(e, isA<ErrorEndpointDirectoryNotFound>());
      thrown = true;
    }

    expect(thrown, isTrue);

    try {
      Sources(sourcesDir: "example/endpoint");
    } catch (e) {
      // forced
      expect(true, isFalse);
      // rethrow or exit?
    }
  });
}

// [1] https://pub.dev/documentation/test_api/latest/expect/throwsA.html
/// need to come back to this
