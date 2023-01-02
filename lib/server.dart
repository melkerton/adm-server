import 'dart:io';

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

    return;
  }

  void listen() async {
    if (httpServer == null) {
      throw ErrorServerNotBound();
    }

    await httpServer!.forEach((request) {
      request.response.close();
    });
  }

  int get port => httpServer != null ? httpServer!.port : 0;
}
