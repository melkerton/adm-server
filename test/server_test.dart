import 'package:test/test.dart';
import 'package:xperi_dart_mock/xperi_dart_mock.dart';

main() {
  test('simple', () {
    final server = Server();
    expect(server.port, equals(999));
  });
}
