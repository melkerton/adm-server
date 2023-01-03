// dart
import 'dart:io';

// package

// local

import 'package:xperi_dart_mock/endpoint.dart';
import 'package:xperi_dart_mock/error.dart';

/// need to do ErrorEndpointDirectoryNotFound check on init

class Sources {
  final sourcesDir;
  Sources({required this.sourcesDir}) {
    final endpointDir = Directory(sourcesDir);
    if (endpointDir.existsSync() == false) {
      throw ErrorEndpointDirectoryNotFound();
    }
  }

  Endpoint? getEndoint(int httpRequest) {
    final endpointFile = File("$sourcesDir/index.yaml");

    if (endpointFile.existsSync() == false) {
      throw ErrorEndpointIndexFileNotFound();
    }

    return Endpoint(endpointFile: endpointFile);
  }

  //throw ErrorEndpointDirectoryNotFound();
}

/*

Sources controls file management
it sprime role is look in DataDir for a file
*/
