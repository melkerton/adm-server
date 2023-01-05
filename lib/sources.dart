// dart
import 'dart:io';

// package
import 'package:adm_server/endpoint.dart';
import 'package:adm_server/system.dart';

// local

class Sources {
  System system;

  /// Default constructor
  Sources(this.system) {
    /// initial state inspection
    /// reports value being used or
    /// guidance on how to proceed

    /// where our index.yaml file is
    /// this is the directory adms_server is called in
    /// so it clearly exists (testing allow direct setting)

    // report found
    //Sources.log.info("Sources(${system.absSourcesDirPath}).");
  }

  bool endpointFileExists(File endpointFile) {
    if (endpointFile.existsSync() == false) {
      //SherpaEndpointIndexFileNotFound(endpointFile);
      return false;
    }

    return true;
  }

  Endpoint? getEndpoint() {
    // find our specfic endpointfile
    String endpointFilePath = "${system.absSourcesDirPath}/index.yaml";

    File endpointFile = File(endpointFilePath);

    if (endpointFileExists(endpointFile) == false) {
      return null;
    }

    return Endpoint(endpointFile: endpointFile);
  }

  bool sourcesDirExists() {
    if (system.sourcesDir.existsSync() == false) {
      // add Sherpa
      return false;
    }

    return true;
  }
}
