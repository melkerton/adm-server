import 'dart:io';

import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/response_writers/response_writer.dart';
import 'package:yaml/yaml.dart';

class Endpoint {
  File endpointFile;
  YamlList? yamlList;

  /// throws error on bad yaml
  Endpoint({required this.endpointFile}) {
    // first check is empty file

    String contents = endpointFile.readAsStringSync();
    if (contents.isEmpty) {
      throw ErrorEndpointConfig();
    }

    // load a nom empty file
    yamlList = loadYaml(contents);

    // is a yamlMap
    if (yamlList![0].runtimeType != YamlMap) {
      throw ErrorEndpointConfig();
    }

    YamlMap yamlMap = yamlList![0];

    // no response
    if (yamlMap.containsKey('response') == false) {
      throw ErrorEndpointConfig();
    }

    /*
    // will be File
    final responseFile = File("${endpointFile.path}/${yamlMap['response']}");
    if (responseFile.existsSync() == false) {
      throw ErrorEndpointConfig();
    }
    */
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
