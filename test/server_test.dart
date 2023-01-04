// dart

// package

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:adm_server/error.dart';
import 'package:adm_server/server.dart';

import 'logger.dart';

// local

main() {
  setUp(() {
    TestLogger.record();
  });

  /// test server responds
  /// Release Test 2. An unmatched response (452 Unmatched)
  test('DefaultServer', () async {
    final server = Server();

    // default
    expect(server.port, 0);

    // port not bound
    expect(server.listen, throwsA(isA<ErrorServerNotBound>()));

    // clear skies
    await server.bind();
    expect(server.port, greaterThan(0));

    // server listens for requests
    server.listen();

    // make a request
    final client = http.Client();
    final uri = Uri.parse("http://localhost:${server.port}");
    final response = await client.get(uri);

    // check we get a 452 response with correct protocolVersion
    expect(response.statusCode, equals(452));
    expect(response.reasonPhrase, equals("Unmatched"));

    // check x-requested-uri is set and correct
    expect(response.headers.containsKey('x-requested-uri'), isTrue);

    expect(response.headers['x-requested-uri'], equals(''));

    // close the thing
    await server.httpServer!.close();
  });

  test('TestServer', () async {
    final server = Server();
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
}
