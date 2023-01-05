// dart

// package

import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

import 'package:adm_server/server.dart';

import 'helpers.dart';

// local

main() {
  setUp(() {
    //TestLogger.record();
  });

  test('TestServer', () async {
    Uri uri;
    Response response;

    // is listening?
    final server = Server(sourcesDirPath: 'test/data/server');
    await server.bind();
    server.listen();

    /// test initialization
    // get current server uri
    expect(server.uri, isNotNull);

    // make sure uri is as expected
    uri = Uri.parse("http://127.0.0.1:4202");
    expect(server.uri, equals(uri));

    /// test responses path = '/'
    response = await Client().get(uri);

    // response should be 200 and contain ADMS
    expect(response.statusCode, equals(200));
    expect(response.body.contains('Welcome to ADM Server'), isTrue);

    /// test responses path = 'alpha'
    uri = Uri.parse("${server.uri}/alpha");
    response = await Client().get(uri);

    expect(response.statusCode, equals(200));
    expect(response.body.contains('Alpha'), isTrue);

    /// test responses path = 'no-match'
    uri = Uri.parse("${server.uri}/no-match");
    response = await Client().get(uri);

    expect(response.statusCode, equals(452));
    expect(response.body, isEmpty);

    // close the server
    server.close();
  });

  test('TestServerMissingEndpoint', () async {
    // is listening?
    final server = Server(sourcesDirPath: 'test/data/server/missing-endpoint');
    await server.bind();
    server.listen();

    final uri = Uri.parse("${server.uri}/alpha");
    final response = await Client().get(uri);

    expect(response.statusCode, equals(452));

    // close the server
    server.close();
  });

  /*
  /// test server responds
  /// Release Test 2. An unmatched response (452 Unmatched)
  test('DefaultServer', () async {
    final server = Server(".");

    // default
    expect(server.port, 0);

    // port not bound

    // clear skies
    await server.bind();
    expect(server.port, greaterThan(0));

    // server listens for requests
    server.listen();

    // make a request
    final client = http.Client();
    final uri = Uri.parse("http://localhost:${server.port}/no-path");
    final response = await client.get(uri);

    // check we get a 452 response with correct protocolVersion
    expect(response.statusCode, equals(452));
    expect(response.reasonPhrase, equals("Unmatched"));

    // check x-requested-uri is set and correct
    expect(response.headers.containsKey('x-requested-uri'), isTrue);

    expect(response.headers['x-requested-uri'], equals('no-path'));

    // close the thing
    await server.httpServer!.close();
  });

  test('TestServer', () async {
    final server = Server("example/endpoint");
    await server.bind();
    server.listen();

    // tests
    final client = http.Client();
    final uri = Uri.parse("http://localhost:${server.port}/alpha");
    final response = await client.get(uri);
    print(response.statusCode);

    // cleanup
    await server.httpServer!.close();
  });
  */
}
