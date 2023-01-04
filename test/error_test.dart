import 'package:adm_server/adm_server.dart';
import "package:test/test.dart";

// Server handles all errors
main() {
  test('Error', () {
    //
    // no endpoint found
    // make sure we are catching errors in server.dart and reporting
    final server = Server("my/endpoint/path");
  });
}
