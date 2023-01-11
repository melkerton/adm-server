import 'dart:io';

import 'package:adm_server/endpoint.dart';
import 'package:adm_server/entry_matcher.dart';
import 'package:adm_server/response_builder.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

main() {
  test('TestResponseBuilder', () async {
    Response shelfResponse;
    String body;

    /// string (no prefix)
    shelfResponse = await getResponse("x-adms-status-code: 202\n\nalpha");
    expect(shelfResponse.statusCode, equals(202));

    /// unrecognized prefix
    shelfResponse = await getResponse("data!empty");
    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, equals('data!empty'));

    /// flat prefix
    shelfResponse = await getResponse("flat!flat-sample");
    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, equals('flat-sample'));

    /// headers only
    shelfResponse = await getResponse("flat!headers");
    expect(shelfResponse.statusCode, equals(200));

    body = await shelfResponse.readAsString();
    expect(body, isEmpty);

    // body only
    shelfResponse = await getResponse("flat!body");
    expect(shelfResponse.statusCode, equals(200));
    body = await shelfResponse.readAsString();
    expect(body.contains("id"), isTrue);

    // pipe (almost)
    shelfResponse = await getResponse("exec!pipe-simple.py");
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

Future<Response> getResponse(String entryPropertyValue,
    {Request? request}) async {
  File endpointFile = File("test/data/response-builder/index.yaml");

  Endpoint endpoint = Endpoint(endpointFile: endpointFile);
  EntryProperty entryProperty = EntryProperty(entryPropertyValue);

  YamlMap entry = loadYaml("{}");
  ResponseBuilder builder = ResponseBuilder(endpoint, entry, entryProperty);

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
