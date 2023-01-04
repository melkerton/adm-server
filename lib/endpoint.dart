import 'dart:io';

import 'package:path/path.dart' show dirname;
import 'package:logging/logging.dart';
import 'package:adm_server/error.dart';
import 'package:adm_server/response_writer.dart';
import 'package:yaml/yaml.dart';

/// if no valid response is found a DefaultWriterResponse is returned
///
/// a default response must be defined in endpoint/index,yaml
/// all others can be empty, helps in gradual building of endpoints
class Endpoint {
  File endpointFile;
  String baseName = "";
  YamlList? yamlList;

  static Logger log = Logger("Endpoint");

  ResponseWriter? defaultResponseWriter;

  /// throws error on bad yaml
  Endpoint({required this.endpointFile}) {
    // ensures is YamlList
    baseName = dirname(endpointFile.path);
    validateEndpoint();
  }

  void validateEndpoint() {
    // first check is empty file

    final msgBase = endpointFile;
    String contents = endpointFile.readAsStringSync();

    if (contents.isEmpty) {
      return;
    }

    // load file contents
    final readYamlList = loadYaml(contents);
    if (readYamlList.runtimeType != YamlList) {
      Endpoint.log.severe("$msgBase runtimeType != YamlList");
      throw ErrorEndpointExpectedYamlList();
    }

    yamlList = readYamlList;
  }

  ResponseWriter? getResponseWriter(String requestedUri) {
    if (yamlList == null) {
      return null;
    }

    Endpoint.log.info("Testing Endpoint Response");

    // only retruns
    // check for matches
    for (final YamlMap response in yamlList!) {
      if (response.containsKey('path')) {
        if (response.containsKey('response') == false) {
          throw ErrorEndpointResponseIsUndefined();
        }

        if (response['path'] == requestedUri.substring(1)) {
          final responseFilePath = "$baseName/${response['response']}";
          final responseFile = File(responseFilePath);
          if (responseFile.existsSync() == false) {
            throw ErrorEndpointResponseFileNotFound();
          }

          return ResponseWriter(responseFile: responseFile);
        }
      }
    }

    // only return if path match found
    return null;
  }
}

/*
  // originally buildDefaultResponseWriter
  // no needed unitl support for default is required
    // no response
    if (yamlMap.containsKey('response') == false) {
      Endpoint.log.severe("$msgBase undefined response");
      throw ErrorEndpointResponseIsUndefined();
    }


    // response files exists?
    final responseFilePath = [dirname(endpointFile.path), yamlMap['response']];

    // only set a default if 
    final responseFile = File(responseFilePath.join('/'));
    if (responseFile.existsSync() == false) {
      defaultResponseWriter = ResponseWriter.builder(responseFile);
    }
*/
