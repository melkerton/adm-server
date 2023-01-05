// dart
import 'dart:io';

// package
import 'package:adm_server/sherpa.dart';
import 'package:logging/logging.dart';

// local

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

  String? getHttpResponseMessage() {
    // check non empty
    final httpMessage = responseFile.readAsStringSync();
    if (httpMessage.isEmpty) {
      SherpaHttpResponseIsEmpty(responseFile);
      return null;
    }

    // readAsBytesSync
    return httpMessage;
  }
}
