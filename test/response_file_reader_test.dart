import 'dart:io';

import 'package:adm_server/response_builder.dart';
import 'package:adm_server/response_file_reader.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

/// ResponseBuilder({required this.responseFile});
/// static ResponseBuilder builder(File responseFile)
/// Future<String?> getHttpResponseMessage({HttpRequest? httpRequest}) async
///

main() {
  test('TestResponseFileReader', () async {
    // no header
    List<String> lines = ['no-header'];
    ResponseFileReader reader = ResponseFileReader(lines);
    expect(reader.hasHeaders(), isFalse);
    expect(reader.body, equals('no-header'));

    // has header
    lines = ['x-adms-status-code: 201'];
    reader = ResponseFileReader(lines);
    expect(reader.hasHeaders(), isTrue);
    expect(reader.body, isNull);
  });
}

/*
TOL
ResponseMessage rm = endpoint.getResponseMessage(request);

return endpoint.getMockResponse(request);

CASE

data-empty: bodyDelim = -1 
data-headers: bodyDelim > 0
data-body: bodyDelim = 1, first line starts with '-'

Rules 

data-empty: none
data-headers: none
data-body: 

how to tell between, 

inspect first line if it contains exactly one ':' it 
  hasHeaders tests
    full line contains exactly one ':'
    key contains matches http header field specs
    // TMP match regex 
*/
