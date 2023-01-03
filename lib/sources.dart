// dart
import 'dart:io';

// package

// local

import 'package:logging/logging.dart';
import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';

/// need to do ErrorEndpointDirectoryNotFound check on init

class Sources {
  Directory sourcesDir;
  Sources({required this.sourcesDir});

  static Sources connect(String arg) {
    // make sure sourcesDir exists
    final sourcesDir = Directory(arg);
    if (sourcesDir.existsSync() == false) {
      throw ErrorSourcesDirNotFound();
    }

    return Sources(sourcesDir: sourcesDir);
  }

  Endpoint getEndpoint() {
    final endpointFile = File("$sourcesDir/index.yaml");

    if (endpointFile.existsSync() == false) {
      throw ErrorSourcesEndpointFileNotFound();
    }

    return Endpoint(endpointFile: endpointFile);
  }

  static void throwAError() {
    throw Error();
  }

  static void throwAErrorArgument(int arg) {
    throw Error();
  }
}

/*

Sources controls file management
it sprime role is look in DataDir for a file
*/
