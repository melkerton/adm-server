// dart
import 'dart:io';

// package

import 'package:adm_server/system.dart';
import 'package:test/test.dart';
import 'package:adm_server/sources.dart';

import 'helpers.dart';

// local

// we don't throw errors anymore, we report and continue
main() {
  setUp(() {
    TestLogger.record();
  });

  test('TestSources', () {
    System system = validSystem();
    Sources sources;

    /// test valid Source
    sources = Sources(system);
    expect(sources.sourcesDirExists(), isTrue);

    File endpointFile = File("${system.absSourcesDirPath}/index.yaml");
    expect(sources.endpointFileExists(endpointFile), isTrue);

    expect(sources.getEndpoint(), isNotNull);
  });
}
