// dart

// package

// local

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:adm_server/error.dart';

// default response writer
// returns file contents as Http Message
class ResponseWriter {
  File responseFile;
  static Logger log = Logger("ResponseWriter");

  ResponseWriter({required this.responseFile});

  static ResponseWriter builder(File responseFile) {
    // builder may still be required for future validations ? asserts?

    // check if is *.pipe && executable
    return ResponseWriter(responseFile: responseFile);
  }

  String getHttpResponseMessage() {
    // check non empty
    final httpMessage = responseFile.readAsStringSync();
    if (httpMessage.isEmpty) {
      ResponseWriter.log
          .severe("HttpMessage cannot be empty ${responseFile.path}");

      // log.setup
      throw ErrorResponseWriterEmptyHttpMessage();
    }

    // readAsBytesSync
    return httpMessage;
  }
}
