import 'dart:io';

import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';

main() {
  bool haveLog = false;
  setUp(() {
    if (haveLog == false) {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      });

      haveLog = true;
      return;
    }
  });

  test('EndpointEmptyFile', () {
    final fileName = "example/errors/empty-index/index.yaml";

    bool thrown = false;
    try {
      Endpoint(endpointFile: File(fileName));
    } catch (e) {
      expect(e, isA<ErrorEndpointConfig>());
      thrown = true;
    }

    expect(thrown, isTrue);
  });

  test('EndpointFirstIsNotYampMap', () {
    final fileName = "example/errors/not-yaml-map/index.yaml";

    bool thrown = false;
    try {
      Endpoint(endpointFile: File(fileName));
    } catch (e) {
      expect(e, isA<ErrorEndpointConfig>());
      thrown = true;
    }

    expect(thrown, isTrue);
  });

  test('EndpointFirstIsNotResponse', () {
    final fileName = "example/errors/not-response/index.yaml";

    bool thrown = false;
    try {
      Endpoint(endpointFile: File(fileName));
    } catch (e) {
      expect(e, isA<ErrorEndpointConfig>());
      thrown = true;
    }

    expect(thrown, isTrue);
  });

  /*

  test('EndpointFirstResponse404', () {
    Sources sources = Sources(sourcesDir: "example/errors/response-404");

    bool thrown = false;
    try {
      sources.getEndpoint();
    } catch (e) {
      expect(e, isA<ErrorEndpointConfig>());
      thrown = true;
    }

    expect(thrown, isTrue);
  });

  test('EndpointFirstHasDefaultResponse', () {
    Sources sources = Sources(sourcesDir: "example/endpoint");

    try {
      sources.getEndpoint();
    } catch (e) {
      // forced
      //expect(true, isFalse);
    }
  });
  */
}

/*
yaml will handle its own errors

how do we handle bad yaml, for now it is a system failure
as it is the only endpoint file available
*/
