// dart
import 'dart:io';

// package
import 'package:adm_server/response_file_reader.dart';
//import 'package:adm_server/pipe_response_writer.dart';
//import 'package:adm_server/sherpa.dart';
import 'package:shelf/shelf.dart';

// local

// default response writer
// returns file contents as Http Message
class ResponseBuilder {
  File responseFile;
  //static Logger log = Logger("ResponseWriter");

  // responseFile existance checked in endpoint.getResponseBuilder
  ResponseBuilder({required this.responseFile});

  Response shelfResponse() {
    // could be a pipe
    // read as lines to consume headers and body seperate
    final httpMessage = responseFile.readAsLinesSync();

    if (httpMessage.isEmpty) {
      return Response(200);
    }

    // process data file
    ResponseFileReader reader = ResponseFileReader(httpMessage);

    // non-empty
    return Response(reader.statusCode,
        headers: reader.headers, body: reader.body);
  }
}