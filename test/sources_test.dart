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

  test('TestSources', () {
    Sources sources;
    String sourcesTestPath = "test/data/sources";

    /// test no sources
    sources = Sources('$sourcesTestPath/doesn-exist');
    expect(sources.sourcesDir.existsSync(), isFalse);

    /// test no index.yaml
    sources = Sources("$sourcesTestPath/no-index");
    expect(sources.endpointFile.existsSync(), isFalse);

    /// test sourcesDir found and path has no trailing PS and exists
    sources = Sources('$sourcesTestPath/');
    expect(sources.absSourcesDirPath.endsWith('/'), isFalse);
    expect(sources.sourcesDir.existsSync(), isTrue);

    /// test endpointFile exists
    sources = Sources('$sourcesTestPath/valid');
    expect(sources.endpointFile.existsSync(), isTrue);

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
