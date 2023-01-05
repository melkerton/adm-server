// dart
import 'dart:io';

// package

import 'package:test/test.dart';

import 'package:adm_server/sources.dart';

import 'logger.dart';

// local

// we don't throw errors anymore, we report and continue
main() {
  setUp(() {
    TestLogger.record();
  });

  test('SourcesDirNotFound', () {
    /*
    String sourcesDir;

    sourcesDir = "example/errors/sources/do-not-create";
    */
    // should not error
    // getEndpoint
  });
}

// [1] https://pub.dev/documentation/test_api/latest/expect/throwsA.html
/// need to come back to this
