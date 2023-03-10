import 'dart:io';

import 'package:adm_server/response_reader.dart';
import 'package:test/test.dart';

/// ResponseBuilder({required this.responseFile});
/// static ResponseBuilder builder(File responseFile)
/// Future<String?> getHttpResponseMessage({HttpRequest? httpRequest}) async
///

main() {
  test('TestResponseReader', () async {
    // body only
    List<String> lines = ['no-header'];
    ResponseReader reader = ResponseReader(lines);
    expect(reader.hasHeaders(), isFalse);
    expect(reader.body, equals('no-header'));

    // header only + status code
    lines = ['x-adms-status-code: 201'];
    reader = ResponseReader(lines);
    expect(reader.hasHeaders(), isTrue);
    expect(reader.body, isNull);
    expect(reader.headers.containsKey('x-adms-status-code'), isTrue);
    expect(reader.statusCode, equals(201));

    lines = ['Content-Type: app/text', '', 'body-test'];
    reader = ResponseReader(lines);
    expect(reader.hasHeaders(), isTrue);

    expect(reader.body, isNotNull);
    expect(reader.body!.contains('body'), isTrue);

    expect(reader.headers.containsKey('Content-Type'), isTrue);
    expect(reader.headers['Content-Type'], equals('app/text'));

    expect(reader.statusCode, equals(200));

    // test body only
    lines = ['{"id": 1}'];
    reader = ResponseReader(lines);
    expect(reader.hasHeaders(), isFalse);
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
