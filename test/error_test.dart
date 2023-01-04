import 'package:adm_server/sources.dart';
import "package:test/test.dart";
import 'logger.dart';

// Server handles all errors
main() {
  setUp(() => TestLogger.record());

  test('SourcesInit', () {
    //
    // no endpoint found
    // make sure we are catching errors in server.dart and reporting
    //final server = Server("my/endpoint/path");
    Sources('red');
    Sources('example');
    Sources('example/endpoint');
  });
}
