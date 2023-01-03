import 'dart:io';

// dart

// package

// local

import 'package:logging/logging.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/response_writer.dart';
import 'package:xperi_dart_mock/sources.dart';

/// Handle mock requests
///
///
class Server {
  HttpServer? httpServer;

  static Logger log = Logger("Server");

  /// Default constructor
  Server();

  Future<void> bind() async {
    httpServer = await HttpServer.bind("localhost", 7170);
  }

  void listen() async {
    if (httpServer == null) {
      // needed? seems like an error to yourself
      Server.log.severe("Bind server before listen.");
      throw ErrorServerNotBound();
    }

    final sourcesDir = Directory("example/endpoint");
    Sources sources = Sources(sourcesDir: sourcesDir);

    await httpServer!.forEach((HttpRequest httpRequest) async {
      final message = "${httpRequest.method} ${httpRequest.requestedUri}";
      Server.log.info(message);

      final endpoint = sources.getEndpoint();
      Server.log.info("Endpoint? ${endpoint != null}");
      ResponseWriter? responseWriter;

      if (endpoint != null) {
        final path = httpRequest.requestedUri.path;
        responseWriter = endpoint.getResponseWriter(path);
        Server.log.fine("ResponseWriter? ${responseWriter != null}");
        await sendRaw(httpRequest, responseWriter);
      } else {
        await sendRaw(httpRequest, null);
      }

      await httpRequest.response.close();
    });
  }

  Future<void> sendRaw(
      HttpRequest httpRequest, ResponseWriter? responseWriter) async {
    Server.log.info("sendRaw 452 ${responseWriter == null}");
    final response = httpRequest.response;

    // detach socket so we can pass Http Message from a Writer
    final socket = await response.detachSocket(writeHeaders: false);

    if (responseWriter != null) {
      socket.write(responseWriter.getHttpResponseMessage());
    } else {
      // no match found
      socket.write("HTTP/${httpRequest.protocolVersion} 452 Unmatched\n");

      final path = httpRequest.requestedUri.path;
      socket.write("x-requested-uri: ${path.substring(1)}\n");
    }

    socket.write("\n");

    await socket.flush(); // [1]
    await socket.close();
  }

  int get port => httpServer != null ? httpServer!.port : 0;
}

// [1] https://api.dart.dev/stable/2.18.6/dart-io/IOSink/close.html