import 'dart:io';

// dart

// package

// local

import 'package:logging/logging.dart';
import 'package:adm_server/error.dart';
import 'package:adm_server/response_writer.dart';
import 'package:adm_server/sources.dart';

/// Handle mock requests
///
///
class Server {
  HttpServer? httpServer;

  static Logger log = Logger("Server");
  late Sources sources;

  /// Default constructor
  Server(String sourcesDirPath) {
    sources = Sources(sourcesDirPath);
  }

  Future<void> bind() async {
    httpServer = await HttpServer.bind("localhost", 7170);
    log.info("Listening on http://localhost:${httpServer!.port}.");
  }

  void listen() async {
    if (httpServer == null) {
      // needed? seems like an error to yourself
      Server.log.severe("Bind server before listen.");
      throw Error();
    }

    await httpServer!.forEach((HttpRequest httpRequest) async {
      // logging
      final message = "${httpRequest.method} ${httpRequest.requestedUri}";
      Server.log.info(message);

      // find endpoint
      final endpoint = sources.getEndpoint();

      if (endpoint != null) {
        Server.log.info("Found Endpoint ${endpoint.baseName}.");
        final path = httpRequest.requestedUri.path;
        ResponseWriter? responseWriter = endpoint.getResponseWriter(path);
        await sendRaw(httpRequest, responseWriter);
      } else {
        await sendRaw(httpRequest, null);
      }

      await httpRequest.response.close();
    }).catchError((e) {
      Server.log.severe("Caught error ${e.runtimeType}");
    });
  }

  Future<void> sendRaw(
      HttpRequest httpRequest, ResponseWriter? responseWriter) async {
    //Server.log.info("sendRaw 452 ${responseWriter == null}");
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

/*
  fatal errors should exit without 
*/