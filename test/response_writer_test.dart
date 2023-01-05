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
/*
Checks are performed when Server writes the response

HttpMessage checks
contains a non-empty line 
and ends with  newline
*/