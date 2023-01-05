import 'dart:io';

import 'package:adm_server/response_builder.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

main() {
  test('TestResponseBuilder', () async {
    Response shelfResponse;
    String body;

    /// empty responseFile
    shelfResponse = await getResponse("data-empty");
    //expect(shelfResponse)
    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, isEmpty);

    /// headers only
    shelfResponse = await getResponse("data-headers");
    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, isEmpty);

    /// body only
  });
}

Future<Response> getResponse(String responseFilePath) async {
  File responseFile = File("test/data/response-builder/$responseFilePath");
  ResponseBuilder builder = ResponseBuilder(responseFile: responseFile);
  return builder.shelfResponse();
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
