// dart
import 'dart:io';

// package
import 'package:adm_server/pipe_response_writer.dart';
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

    // check if is *.pipe
    if (responseFile.path.startsWith('pipe-')) {
      return PipeResponseWriter(responseFile: responseFile);
    }

    return ResponseWriter(responseFile: responseFile);
  }

  Future<String?> getHttpResponseMessage({HttpRequest? httpRequest}) async {
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
