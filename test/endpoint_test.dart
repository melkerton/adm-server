import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:adm_server/endpoint.dart';

import 'logger.dart';
import 'mock.dart';

main() {
  setUp(() {
    //TestLogger.record();
  });

  test('TestEndpoint', () {
    // create a
    final endpointFile = File('test/data/_valid/index.yaml');
    final endpoint = Endpoint(endpointFile: endpointFile);
  });
}
