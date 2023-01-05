// dart
import 'dart:io';

// package
import 'package:adm_server/response_reader.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';

// local

// default response writer
// returns file contents as Http Message
class ResponseBuilder {
  File responseFile;
  //static Logger log = Logger("ResponseWriter");

  // responseFile existance checked in endpoint.getResponseBuilder
  ResponseBuilder({required this.responseFile});

  Future<Response> shelfResponse(Request request) async {
    List<String> httpMessage = [];

    /// TODO write pipe handler
    // could be a pipe
    // if it's a pipe grab
    // httpMessage = get-pipe-data
    // read as lines to consume headers and body seperate

    String baseName = basename(responseFile.path);
    if (baseName.startsWith('pipe-')) {
      String message = await getPipeMessage(responseFile, request);

      // OS
      httpMessage = message.split('\n');
    } else {
      httpMessage = responseFile.readAsLinesSync();
    }

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

/// v0.0.1 limitation ONLY gets http://host:port/path?query via arguents
Future<String> getPipeMessage(File executable, Request request) async {
  // start executable
  List<String> arguments = [request.requestedUri.toString()];

  var result = await Process.run(executable.absolute.path, arguments);
  return result.stdout;
}

/*
  final String executable;

  /// arguments to use with executable
  final List<String> arguments;

  /// PipeResponse default constructor.
  PipeResponse({required this.executable, required this.arguments});

  /// abstract sends data (raw) or returns Map (json).
  Future<dynamic> render(IncomingRequest incomingRequest);

  /// abstract prepares stdin that will be piped to executable
  String stdinData(IncomingRequest incomingRequest);

  /// returns stdout stream
  Future<Stream<List<int>>> execute(IncomingRequest incomingRequest) async {
    // start executable
    var process = await Process.start(executable, arguments);
    // capture stdout and send to controller

    // pipe data to executable
    process.stdin.write(stdinData(incomingRequest));
    process.stdin.close();
    return process.stdout;
*/