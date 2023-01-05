@Skip("ResponseWriter")
import 'dart:io';

import 'package:test/test.dart';
import 'logger.dart';
import 'package:adm_server/response_writer.dart';

main() {
  setUp(() {
    TestLogger.record();
  });

  test('ResponseWriterEmptyHttpMessage', () {});
}
