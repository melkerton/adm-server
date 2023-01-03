// dart
import 'dart:io';

// package

// local

import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';

/// need to do ErrorEndpointDirectoryNotFound check on init

class Sources {
  String sourcesDir;
  Sources({required this.sourcesDir}) {
    final endpointDir = Directory(sourcesDir);
    if (endpointDir.existsSync() == false) {
      throw ErrorEndpointDirectoryNotFound();
    }
  }

  Endpoint? getEndpoint() {
    final endpointFile = File("$sourcesDir/index.yaml");

    if (endpointFile.existsSync() == false) {
      throw ErrorEndpointIndexFileNotFound();
    }

    return Endpoint(endpointFile: endpointFile);
  }
}

/*

Sources controls file management
it sprime role is look in DataDir for a file
*/
