import 'dart:io';

import 'package:adm_server/sherpa.dart';
import 'package:path/path.dart' show dirname;
import 'package:logging/logging.dart';
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
      Endpoint.log.config("$msgBase runtimeType != YamlList");
      return;
    }

    yamlList = readYamlList;
  }

  ResponseWriter? getResponseWriter(String requestedUri) {
    if (yamlList == null) {
      return null;
    }

    // only returns
    // check for matches
    for (final YamlMap response in yamlList!) {
      Endpoint.log.info('Inspecting $response.');

      if (response.containsKey('path')) {
        if (response.containsKey('response') == false) {
          SherpaEndpointResponseIsNull(endpointFile, response);
          continue;
        }

        if (response['path'] == requestedUri.substring(1)) {
          final responseFilePath = "$baseName/${response['response']}";
          final responseFile = File(responseFilePath);
          if (responseFile.existsSync() == false) {
            SherpaEndpointResponseFileNotFound(responseFile);
            continue;
          }

          Endpoint.log.info('Building ResponseWriter.');
          return ResponseWriter.builder(responseFile);
        }
      }
    }

    log.info("Endpoint did not find a ResponseWriter");
    // only return if path match found
    return null;
  }
}
