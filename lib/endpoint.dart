import 'dart:io';
import 'package:adm_server/entry_matcher.dart';
import 'package:shelf/shelf.dart';

import 'package:path/path.dart' show dirname;
import 'package:adm_server/response_builder.dart';
import 'package:yaml/yaml.dart';

/// all others can be empty, helps in gradual building of endpoints
class Endpoint {
  File endpointFile;
  YamlList? yamlList;

  //static Logger log = Logger("Endpoint");

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

  // matches are against request.url.path (includes query)
  Future<ResponseBuilder?> getResponseBuilder(Request request) async {
    if (yamlList == null) {
      return null;
    }

    // only returns
    // check for matches
    for (final YamlMap entry in yamlList!) {
      //Endpoint.log.info('Inspecting $response.');
      if (entry.containsKey('path')) {
        if (entry.containsKey('response') == false) {
          //SherpaEndpointResponseIsNull(endpointFile, response);
          continue;
        }

        EntryMatcher entryMatcher = EntryMatcher(entry, request);

        if (await entryMatcher.isMatch) {
          final responseFilePath = "$dirPath/${entry['response']}";
          final responseFile = File(responseFilePath);

          if (responseFile.existsSync() == false) {
            //SherpaEndpointResponseFileNotFound(responseFile);
            continue;
          }

          //Endpoint.log.info('Building ResponseWriter.');
          return ResponseBuilder(responseFile: responseFile);
        }
      }
    }

    // only return if path match found
    return null;
  }
}
