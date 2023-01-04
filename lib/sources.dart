// dart
import 'dart:io';

// package

// local

import 'package:logging/logging.dart';
import 'package:adm_server/endpoint.dart';
import 'package:adm_server/error.dart';

/// need to do ErrorEndpointDirectoryNotFound check on init

class Sources {
  Directory sourcesDir;

  static Logger log = Logger("Sources");
  Sources({required this.sourcesDir});

  static Sources connect(String arg) {
    // make sure sourcesDir exists
    final sourcesDir = Directory(arg);
    if (sourcesDir.existsSync() == false) {
      Sources.log.severe("$sourcesDir not found.");
      throw ErrorSourcesDirNotFound();
    }

    return Sources(sourcesDir: sourcesDir);
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
