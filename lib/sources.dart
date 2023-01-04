// dart
import 'dart:io';

// package

// local

import 'package:logging/logging.dart';
import 'package:adm_server/endpoint.dart';
import 'package:adm_server/error.dart';

class Sources {
  String sourcesDirPath;
  late Directory sourcesDir;

  static Logger log = Logger("Sources");
  // use static connect
  Sources({required this.sourcesDirPath}) {
    // make sure sourcesDir exists
    final sourcesDir = Directory(sourcesDirPath);
    if (sourcesDir.existsSync() == false) {
      Sources.log.severe("$sourcesDir not found.");
      throw ErrorSourcesDirNotFound();
    }
  }

  Endpoint? getEndpoint() {
    String endpointFilePath = "${sourcesDir.path}/index.yaml";
    final endpointFile = File(endpointFilePath);

    if (endpointFile.existsSync() == false) {
      Sources.log.severe("$endpointFilePath not found.");
      throw ErrorSourcesEndpointFileNotFound();
    }

    return Endpoint(endpointFile: endpointFile);
  }
}

/*

Sources controls file management
it sprime role is look in DataDir for a file
*/
