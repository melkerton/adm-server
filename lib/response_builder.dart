// dart
import 'dart:io';

// package
import 'package:adm_server/response_reader.dart';
import 'package:shelf/shelf.dart';

// local

// default response writer
// returns file contents as Http Message
class ResponseBuilder {
  File responseFile;
  //static Logger log = Logger("ResponseWriter");

  // responseFile existance checked in endpoint.getResponseBuilder
  ResponseBuilder({required this.responseFile});

  Future<Response> shelfResponse() async {
    /// TODO write pipe handler
    // could be a pipe
    // if it's a pipe grab
    // httpMessage = get-pipe-data
    // read as lines to consume headers and body seperate
    final httpMessage = responseFile.readAsLinesSync();

    if (httpMessage.isEmpty) {
      return Response(200);
    }

    // process data file
    ResponseReader reader = ResponseReader(httpMessage);

    // non-empty
    return Response(reader.statusCode,
        headers: reader.headers, body: reader.body);
  }
}
