import 'dart:io';

import 'package:adm_server/adms_request.dart';
import 'package:adm_server/response_builder.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:adm_server/endpoint.dart';

main() {
  setUp(() {
    //TestLogger.record();
  });

  test('TestEndpoint', () async {
    // create a
    final endpointFile = File('test/data/_valid/index.yaml');
    final endpoint = Endpoint(endpointFile: endpointFile);

    expect(endpoint.dirPath.endsWith("test/data/_valid"), isTrue);
    expect(endpoint.isValid, isTrue);

    String uriPath = "http://127.0.0.1:4202";

    // test indexInfo

    // test found ResponseBuilder

    Uri uri = Uri.parse("$uriPath/alpha");
    Request shelfRequest = Request("GET", uri);
    AdmsRequest admsRequest = AdmsRequest(shelfRequest);
    ResponseBuilder? writer = await endpoint.getResponseBuilder(admsRequest);
    expect(writer, isNotNull);

    uri = Uri.parse("$uriPath/alpha-missing");
    shelfRequest = Request("GET", uri);
    admsRequest = AdmsRequest(shelfRequest);
    writer = await endpoint.getResponseBuilder(admsRequest);

    expect(writer, isNull);

    // query string
    uri = Uri.parse("$uriPath/alpha?id=1");
    shelfRequest = Request("GET", uri);
    admsRequest = AdmsRequest(shelfRequest);
    writer = await endpoint.getResponseBuilder(admsRequest);
    expect(writer, isNotNull);

    // test not found ResponseBuilder
  });
}
