// dart

// package

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/xperi_dart_mock.dart';

// local

main() {
  /// test server responds
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

    expect(server.uri, equals(Uri.parse("http://localhost:${server.port}")));

    // make a request
    final client = http.Client();
    final response = await client.get(server.uri);

    print(response.reasonPhrase);

    // check we get a 452 response with correct protocolVersion
    expect(response.statusCode, equals(452));
    expect(response.reasonPhrase, equals("Unmatched"));

    // close the thing
    await server.httpServer!.close();
  });
}
