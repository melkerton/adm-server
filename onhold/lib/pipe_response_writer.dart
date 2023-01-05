// dart

import 'dart:convert';
import 'dart:io';

// package
import 'package:logging/logging.dart';

import 'response_writer.dart';

// local

class PipeResponseWriter extends ResponseWriter {
  Logger log = Logger('PipeResponseWriter');

  PipeResponseWriter({required super.responseFile});

  @override
  Future<String?> getHttpResponseMessage({HttpRequest? httpRequest}) async {
    // readAsBytesSync
    log.info('Executing pipe ${responseFile.path}');

    // start executable
    var process = await Process.start(responseFile.path, []);
    // capture stdout and send to controller

    // pipe data to executable
    process.stdin.write(httpRequest?.requestedUri);
    process.stdin.close();

    var lines = process.stdout.transform(utf8.decoder);

    List<String> httpMessage = [];

    // REVIEW THIS (copy+paste)
    try {
      await for (var line in lines) {
        httpMessage.add(line);
      }
    } catch (e) {
      print(e);
    }

    return httpMessage.join();
  }
}
