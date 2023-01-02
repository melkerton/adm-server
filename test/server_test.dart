// dart

// package
import 'package:test/test.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/xperi_dart_mock.dart';

// local

main() {
  /// test server responds
  test('DefaultServer', () async {
    final server = Server();

    expect(server.port, 0);
    //expect(server.port, greaterThan(0));

    // calling listen before bind should throw an exception
    expect(server.listen, throwsA(isA<ErrorServerNotBound>()));

    //await server.bind();
    // get server uri
    // non-zero port
    //expect(server.port, greaterThan(0));

    /// write a plan
  });
}
