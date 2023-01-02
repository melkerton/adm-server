import 'package:test/test.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/xperi_dart_mock.dart';

main() {
  /// test server responds
  test('DefaultServer', () async {
    final server = Server();

    // calling listen before bind should throw an exception
    expect(server.listen, throwsA(isA<ErrorServerNotBound>()));

    //await server.bind();
    // get server uri
    // non-zero port
    expect(server.port, equals(0));

    /// write a plan
  });
}
