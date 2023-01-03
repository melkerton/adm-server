import 'dart:io';

import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';

main() {
  bool haveLog = false;
  setUp(() {
    if (haveLog == false) {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        //print('${record.level.name}: ${record.time}: ${record.message}');
      });

      haveLog = true;
      return;
    }
  });
  test('EndpointErrorConfig', () {
    Matcher matcher = throwsA(isA<ErrorEndpointConfig>());
    String indexFile;
    String basePath = "example/errors/endpoint";

    indexFile = "$basePath/empty-index/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    indexFile = "$basePath/not-yaml-map/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    indexFile = "$basePath/not-response/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);

    indexFile = "$basePath/response-data-404/index.yaml";
    expect(() => Endpoint(endpointFile: File(indexFile)), matcher);
  });
}

/*
yaml will handle its own errors

how do we handle bad yaml, for now it is a system failure
as it is the only endpoint file available
*/
