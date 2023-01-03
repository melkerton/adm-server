import 'dart:io';

import 'package:path/path.dart' show dirname;
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

  static Logger log = Logger("Endpoint");

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
      Endpoint.log.severe("$msgBase contents.isEmpty");
      throw ErrorEndpointIndexFileIsEmpty();
    }

    // load file contents
    yamlList = loadYaml(contents);

    // is a yamlMap?
    if (yamlList![0].runtimeType != YamlMap) {
      Endpoint.log.severe("$msgBase runtimeType != YamlMap");
      throw ErrorEndpointExpectedYamlMap();
    }

    YamlMap yamlMap = yamlList![0];

    // no response
    if (yamlMap.containsKey('response') == false) {
      Endpoint.log.severe("$msgBase undefined response");
      throw ErrorEndpointResponseIsUndefined();
    }

    // response files exists?
    final responseFilePath = [dirname(endpointFile.path), yamlMap['response']];

    final responseFile = File(responseFilePath.join('/'));
    if (responseFile.existsSync() == false) {
      Endpoint.log.severe("$responseFilePath not found.");
      throw ErrorEndpointResponseFileNotFound();
    }

    defaultResponseWriter = ResponseWriter.builder(responseFile);
  }

  ResponseWriter? getResponseWriter() {
    // check for matches

    // if nne found return default
    return defaultResponseWriter;
  }
}
