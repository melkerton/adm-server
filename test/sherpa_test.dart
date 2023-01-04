import 'dart:io';

import 'package:adm_server/endpoint.dart';
import 'package:adm_server/sources.dart';
import "package:test/test.dart";
import 'logger.dart';

// need to write stdout tests
// Server handles all errors
main() {
  late String sherpaData;
  setUp(() => TestLogger.record());

  setUp(() {
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

    String endpointFilePath;

    // undefined response
    endpointFilePath = "$indexFile/undefined-response.yaml";
    Endpoint(endpointFile: File(endpointFilePath))
        .getResponseWriter("no-response");

    // response file not found
    endpointFilePath = "$indexFile/response-not-found.yaml";
    Endpoint(endpointFile: File(endpointFilePath)).getResponseWriter("/alpha");
  });
}
