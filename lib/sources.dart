// dart
import 'dart:io';

// package

// local

import 'package:adm_server/sherpa/sherpa.dart';
import 'package:logging/logging.dart';
import 'package:adm_server/endpoint.dart';

class Sources {
  String sourcesDirPath;

  late String absSourcesDirPath;
  late File endpointFile;
  late Directory sourcesDir;

  static Logger log = Logger("Sources");

  /// Default constructor
  Sources(this.sourcesDirPath) {
    /// initial state inspection
    /// reports value being used or
    /// guidance on how to proceed

    // where our index.yaml file is
    sourcesDir = Directory(sourcesDirPath);

    // generate an absolute path for clarity of reporting
    absSourcesDirPath = sourcesDir.absolute.path;

    if (sourcesDirExists() == false) {
      return;
    }

    // report found
    Sources.log.info("Sources($absSourcesDirPath).");

    // find our specfic endpointfile
    String endpointFilePath = "$absSourcesDirPath/index.yaml";

    endpointFile = File(endpointFilePath);
    if (endpointFileExists() == true) {
      Sources.log.info("Endpoint($absSourcesDirPath).");
    }
  }

  bool endpointFileExists() {
    if (endpointFile.existsSync() == false) {
      //Sherpa.endpointFile(Sources.log, absSourcesDirPath);
      return false;
    }

    return true;
  }

  Endpoint? getEndpoint() {
    if (sourcesDirExists() == false) {
      return null;
    }

    if (endpointFileExists() == false) {
      return null;
    }

    return Endpoint(endpointFile: endpointFile);
  }

  bool sourcesDirExists() {
    if (sourcesDir.existsSync() == false) {
      SherpaSourcesDirNotFound(absSourcesDirPath);
      return false;
    }

    return true;
  }
}
