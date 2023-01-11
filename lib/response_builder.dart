// dart
import 'dart:io';

// package
import 'package:adm_server/endpoint.dart';
import 'package:adm_server/entry_matcher.dart';
import 'package:adm_server/response_reader.dart';
import 'package:shelf/shelf.dart';
import 'package:yaml/yaml.dart';

// local

// default response writer
// returns file contents as Http Message
class ResponseBuilder {
  File? responseFile;
  //static Logger log = Logger("ResponseWriter");
  YamlMap entry;
  Endpoint endpoint;
  EntryProperty entryProperty;

  String get label =>
      entry['label'] ?? "(label not set, add field `label` to entry)";

  // responseFile existance checked in endpoint.getResponseBuilder
  ResponseBuilder(this.endpoint, this.entry, this.entryProperty);

  Future<String> getPrefixResponseHttpMessage(Request request) async {
    String prefix = entryProperty.prefix!;
    File responseFile = File("${endpoint.dirPath}/${entryProperty.value}");

    // pre conditions
    // file exists, valid prefix found

    if (responseFile.existsSync() == true) {
      if (prefix == 'exec') {
        return getPipeMessage(responseFile, request);
      }

      if (prefix == 'flat') {
        return responseFile.readAsStringSync();
      }
    }

    // invalid or not found, return original value
    return [entryProperty.prefix, entryProperty.value]
        .join(EntryProperty.delim);
  }

  // OS
  Future<Response> shelfResponse(Request request) async {
    String httpMessage = entryProperty.value;

    if (entryProperty.prefix != null) {
      httpMessage = await getPrefixResponseHttpMessage(request);
    }

    // process data file
    ResponseReader reader = ResponseReader(httpMessage.split("\n"));

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
