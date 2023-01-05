@Skip("Sherpa")
import 'dart:io';

import 'package:adm_server/endpoint.dart';
import 'package:adm_server/response_writer.dart';
import 'package:adm_server/sources.dart';
import "package:test/test.dart";
import 'logger.dart';

// need to write stdout tests
// Server handles all errors
main() {
  late String sherpaData;

  setUp(() {
    TestLogger.record();
    sherpaData = "test/sherpa-data";
  });

  test('SourceHelp', () {
    // no SourcesDir
    Sources("$sherpaData/no-create");

    // no index.yaml
    Sources("$sherpaData/no-index");
  });

  test('EndpointHelp', () {
    String indexFile = "$sherpaData/index-file";
    Endpoint endpoint;
    String endpointFilePath;

    // undefined response
    endpointFilePath = "$indexFile/undefined-response.yaml";
    endpoint = Endpoint(endpointFile: File(endpointFilePath));
    //endpoint.getResponseWriter("no-response");

    // response file not found
    endpointFilePath = "$indexFile/response-not-found.yaml";
    endpoint = Endpoint(endpointFile: File(endpointFilePath));
    //endpoint.getResponseWriter("/alpha");
  });

  test('ResponseWriter', () {
    final responseFile = File("$sherpaData/empty-response");
    final writer = ResponseWriter(responseFile: responseFile);

    writer.getHttpResponseMessage();
  });
}
