import 'dart:io';

import 'package:adm_server/response_writer.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:adm_server/endpoint.dart';

import 'helpers.dart';

main() {
  setUp(() {
    //TestLogger.record();
  });

  test('TestEndpoint', () {
    // create a
    final endpointFile = File('test/data/_valid/index.yaml');
    final endpoint = Endpoint(endpointFile: endpointFile);

    expect(endpoint.dirPath.endsWith("test/data/_valid"), isTrue);
    expect(endpoint.isValid, isTrue);

    String uriPath = "http://127.0.0.1:4202";

    // test indexInfo

    // test found ResponseWriter

    Uri uri = Uri.parse("$uriPath/alpha");
    Request request = Request("GET", uri);
    ResponseWriter? writer = endpoint.getResponseWriter(request);
    expect(writer, isNotNull);

    uri = Uri.parse("$uriPath/alpha-missing");
    request = Request("GET", uri);
    writer = endpoint.getResponseWriter(request);

    expect(writer, isNull);

    // test not found ResponseWriter
  });
}
