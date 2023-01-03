import 'dart:io';

import 'package:logging/logging.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/response_writer.dart';
import 'package:yaml/yaml.dart';

/// if no valid response is found a DefaultWriterResponse is returned
///
/// a default response must be defined in endpoint/index,yaml
/// all others can be empty, helps in gradual building of endpoints
class Endpoint {
  File endpointFile;
  YamlList? yamlList;
  Logger log = Logger("Endpoint");
  ResponseWriter? defaultResponseWriter;

  /// throws error on bad yaml
  Endpoint({required this.endpointFile}) {
    if (defaultResponseWriter == null) {
      buildDefaultResponseWriter();
    }
  }

  void buildDefaultResponseWriter() {
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

    defaultResponseWriter = ResponseWriter.builder(yamlMap['resource']);
  }

  ResponseWriter? getResponseWriter() {
    // check for matches

    // if nne found return default
    return defaultResponseWriter;
  }
}
