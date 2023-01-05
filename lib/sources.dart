// dart
import 'dart:io';

// package
import 'package:adm_server/sherpa.dart';
import 'package:adm_server/endpoint.dart';
import 'package:logging/logging.dart';

// local

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
      Sources.log.info("Endpoint($endpointFilePath).");
    }
  }

  bool endpointFileExists() {
    if (endpointFile.existsSync() == false) {
      SherpaEndpointIndexFileNotFound(endpointFile);
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
      SherpaSourcesDirNotFound(sourcesDir);
      return false;
    }

    return true;
  }
}
