import 'dart:io';

// dart

// package

// local

import 'package:xperi_dart_mock/error.dart';

/// Handle mock requests
///
///
class Server {
  HttpServer? httpServer;

  /// Default constructor
  Server();

  Future<void> bind() async {
    httpServer = await HttpServer.bind("localhost", 0);
  }

  void listen() async {
    if (httpServer == null) {
      throw ErrorServerNotBound();
    }

    await httpServer!.forEach((HttpRequest httpRequest) async {
      // matching
      // responseWriter = sources.getEndpoint();
      // endpoint = responseWriter.getResponseWriter();

      await sendRaw(httpRequest);
      await httpRequest.response.close();
    });
  }

  Future<void> sendRaw(HttpRequest httpRequest) async {
    final response = httpRequest.response;
    // detach socket so we can pass Http Message from a Writer
    final socket = await response.detachSocket(writeHeaders: false);

    // no match found
    socket.write("HTTP/${httpRequest.protocolVersion} 452 Unmatched\n");
    socket.write("x-requested-uri: alpha\n");
    socket.write("\n");

    await socket.flush(); // [1]
    await socket.close();
  }

  int get port => httpServer != null ? httpServer!.port : 0;
}

// [1] https://api.dart.dev/stable/2.18.6/dart-io/IOSink/close.html