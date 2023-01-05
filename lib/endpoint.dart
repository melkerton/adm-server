import 'dart:io';
import 'package:shelf/shelf.dart';

//import 'package:adm_server/sherpa.dart';
import 'package:path/path.dart' show dirname;
import 'package:logging/logging.dart';
import 'package:adm_server/response_writer.dart';
import 'package:yaml/yaml.dart';

/// all others can be empty, helps in gradual building of endpoints
class Endpoint {
  File endpointFile;
  YamlList? yamlList;

  //static Logger log = Logger("Endpoint");

  ResponseWriter? defaultResponseWriter;

  /// throws error on bad yaml
  Endpoint({required this.endpointFile}) {
    // load yaml list from index.yaml
    yamlList = loadYamlList();
  }

  // getters
  String get dirPath => dirname(endpointFile.absolute.path);
  bool get isValid => yamlList != null;

  // methods

  YamlList? loadYamlList() {
    // first check is empty file
    String contents = endpointFile.readAsStringSync();

    if (contents.isEmpty) {
      return null;
    }

    // load file contents
    final readYamlList = loadYaml(contents);
    if (readYamlList.runtimeType != YamlList) {
      //Endpoint.log.config("$msgBase runtimeType != YamlList");
      return null;
    }

    return readYamlList;
  }

  ResponseWriter? getResponseWriter(Request request) {
    if (yamlList == null) {
      return null;
    }

    // strip leading '/'
    final requestedUri = request.requestedUri.path.substring(1);
    print("ENDPOINT $requestedUri");
    // only returns
    // check for matches
    for (final YamlMap entry in yamlList!) {
      //Endpoint.log.info('Inspecting $response.');
      print("ENDPOINT $entry");
      if (entry.containsKey('path')) {
        print("ENDPOINT entry has path");
        if (entry.containsKey('response') == false) {
          //SherpaEndpointResponseIsNull(endpointFile, response);
          continue;
        }
        print("ENDPOINT entry has response");

        if (entry['path'] == requestedUri) {
          final responseFilePath = "$dirPath/${entry['response']}";
          final responseFile = File(responseFilePath);

          print("ENDPOINT $responseFilePath ?");
          if (responseFile.existsSync() == false) {
            //SherpaEndpointResponseFileNotFound(responseFile);
            continue;
          }

          //Endpoint.log.info('Building ResponseWriter.');
          return ResponseWriter.builder(responseFile);
        }
      }
    }

    // only return if path match found
    return null;
  }
}
