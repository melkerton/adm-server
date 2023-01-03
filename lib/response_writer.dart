// dart

// package

// local

import 'dart:io';

import 'package:xperi_dart_mock/error.dart';

// default response writer
// returns file contents as Http Message
class ResponseWriter {
  File responseFile;
  ResponseWriter({required this.responseFile});

  static ResponseWriter builder(String responseFilePath) {
    final file = File(responseFilePath);
    if (file.existsSync() == false) {
      throw ErrorResponseFilePathNotFound();
    }

    // check if is *.pipe && executable
    return ResponseWriter(responseFile: file);
  }

  List<int> getHttpResponseMessage() {
    // check non empty
    final httpMessage = responseFile.readAsBytesSync();
    print(httpMessage);
    if (httpMessage.isEmpty) {
      throw ErrorResponseWriterEmptyHttpMessage();
    }

    // readAsBytesSync
    return httpMessage;
  }
}
