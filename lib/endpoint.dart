import 'dart:io';

import 'package:logging/logging.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/response_writers/response_writer.dart';
import 'package:yaml/yaml.dart';

class Endpoint {
  File endpointFile;
  YamlList? yamlList;

  /// throws error on bad yaml
  Endpoint({required this.endpointFile}) {
    final log = Logger("Endpoint");

    // first check is empty file

    final msgBase = endpointFile;
    String contents = endpointFile.readAsStringSync();
    if (contents.isEmpty) {
      log.severe("$msgBase contents.isEmpty");
      throw ErrorEndpointConfig();
    }

    // load file contents
    yamlList = loadYaml(contents);

    // is a yamlMap?
    if (yamlList![0].runtimeType != YamlMap) {
      log.severe("$msgBase runtimeType != YamlMap");
      throw ErrorEndpointConfig();
    }

    YamlMap yamlMap = yamlList![0];

    // no response
    if (yamlMap.containsKey('response') == false) {
      log.severe("$msgBase no response");
      throw ErrorEndpointConfig();
    }

    // response files exists?
    final responseFile = File("${endpointFile.path}/${yamlMap['response']}");
    if (responseFile.existsSync() == false) {
      log.severe(endpointFile.path);
      throw ErrorEndpointConfig();
    }

    print(responseFile);
  }

  /*
  ResponseWriter? getResponseWriter() {
    // check each in list for match, but for now we pass back
    // a default
    /*
      temorary condition
      if is empty for sure no match
      else bad config is GEFN
    */

    return ResponseWriter();
  }
  */
}
