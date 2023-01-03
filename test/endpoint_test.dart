import 'package:test/test.dart';
import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/sources.dart';

main() {
  test('EndpointEmptyFile', () {
    Sources sources = Sources(sourcesDir: "example/errors/empty-index");

    bool thrown = false;
    try {
      sources.getEndpoint();
    } catch (e) {
      expect(e, isA<ErrorEndpointConfig>());
      thrown = true;
    }

    expect(thrown, isTrue);
  });

  test('EndpointFirstIsNotYampMap', () {
    Sources sources = Sources(sourcesDir: "example/errors/not-yaml-map");

    bool thrown = false;
    try {
      sources.getEndpoint();
    } catch (e) {
      expect(e, isA<ErrorEndpointConfig>());
      thrown = true;
    }

    expect(thrown, isTrue);
  });

  test('EndpointFirstIsNotResponse', () {
    Sources sources = Sources(sourcesDir: "example/errors/not-response");

    bool thrown = false;
    try {
      sources.getEndpoint();
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
      expect(true, isFalse);
    }
  });
  */
}

/*
yaml will handle its own errors

how do we handle bad yaml, for now it is a system failure
as it is the only endpoint file available
*/
