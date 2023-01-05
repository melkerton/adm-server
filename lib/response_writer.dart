// dart
import 'dart:io';

// package
//import 'package:adm_server/pipe_response_writer.dart';
import 'package:adm_server/sherpa.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';

// local

// default response writer
// returns file contents as Http Message
class ResponseWriter {
  File responseFile;
  static Logger log = Logger("ResponseWriter");

  ResponseWriter({required this.responseFile});

  static ResponseWriter builder(File responseFile) {
    // check if is *.pipe

    // responseFile.path may be absolute
    // so test basename starts with
    final baseName = basename(responseFile.path);
    if (baseName.startsWith('pipe-')) {
      log.info("Building PipeResponse.");
      //return PipeResponseWriter(responseFile: responseFile);
    }

    log.info("Building Response.");
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
