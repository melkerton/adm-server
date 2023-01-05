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

    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, isEmpty);

    /// headers only
    shelfResponse = await getResponse("data-headers");
    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, isEmpty);

    // body only
    shelfResponse = await getResponse("data-body");
    expect(shelfResponse.statusCode, equals(200));
    body = await shelfResponse.readAsString();
    expect(body.contains("id"), isTrue);

    // pipe (almost)
    shelfResponse = await getResponse("pipe-simple.py");
    expect(shelfResponse.statusCode, equals(202));
    body = await shelfResponse.readAsString();
  });

  test('TestResponseBuilderPipe', () async {
    File executable = File('test/data/response-builder/pipe-simple.py');
    Request request = Request("GET", Uri.parse("http://127.0.0.1/beta"));
    String httpMessage = await getPipeMessage(executable, request);
    expect(httpMessage.contains('adms-status-code'), isTrue);
  });
}

Future<Response> getResponse(String responseFilePath,
    {Request? request}) async {
  File responseFile = File("test/data/response-builder/$responseFilePath");
  ResponseBuilder builder = ResponseBuilder(responseFile: responseFile);

  request = request ?? Request("GET", Uri.parse("http://127.0.0.1/"));
  return builder.shelfResponse(request);
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
