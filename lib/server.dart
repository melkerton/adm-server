import 'dart:io';

// dart

// package

// local

import 'package:adm_server/endpoint.dart';
import 'package:adm_server/system.dart';
import 'package:logging/logging.dart';
import 'package:adm_server/response_writer.dart';
import 'package:adm_server/sources.dart';

/// Handle mock requests
///
///
class Server {
  HttpServer? httpServer;

  static Logger log = Logger("Server");
  late Sources sources;

  int portNumber = 7170;

  System system = System();

  /// Default constructor
  Server() {
    sources = Sources(system.sourcesDir.path);
  }

  Future<void> bind() async {
    httpServer = await HttpServer.bind(system.host, system.port);

    // report port from httpServer, port=0 => random port
    log.info("Listening on $uri.");
  }

  Future<void> close() async {
    if (httpServer != null) {
      await httpServer!.close();
    }
  }

  Uri? get uri {
    if (httpServer == null) {
      return null;
    }

    return Uri.parse("http://${system.host}:${httpServer!.port}");
  }

  void listen() async {
    // the bind before listen call is fixed, test not needed

    await httpServer!.forEach((HttpRequest httpRequest) async {
      // logging
      final message = "${httpRequest.method} ${httpRequest.requestedUri}";
      Server.log.info(message);

      /// root call, display info
      if (httpRequest.requestedUri.path == '/') {
        sendIndexInfo(httpRequest);
      } else {
        handleRequest(httpRequest);
      }

      await httpRequest.response.close();
    });
    /*
    // what would cause this error?
    .catchError((e) {
      Server.log.severe("Caught error ${e.runtimeType}");
    });
    */
  }

  Future<void> handleRequest(HttpRequest httpRequest) async {
    final endpoint = sources.getEndpoint();

    if (endpoint == null) {
      await sendRaw(httpRequest, null);
      return;
    }

    Server.log.info("Found Endpoint ${endpoint.baseName}.");
    final path = httpRequest.requestedUri.path;
    ResponseWriter? responseWriter = endpoint.getResponseWriter(path);
    await sendRaw(httpRequest, responseWriter);
  }

  Future<void> sendIndexInfo(HttpRequest httpRequest) async {
    httpRequest.response.write("Welcome to ADM Server!\n"
        "\nAn experimental mock server written in Dart.\n");
  }

  Future<void> sendRaw(
      HttpRequest httpRequest, ResponseWriter? responseWriter) async {
    //Server.log.info("sendRaw 452 ${responseWriter == null}");
    final response = httpRequest.response;

    // detach socket so we can pass Http Message from a Writer
    final socket = await response.detachSocket(writeHeaders: false);

    if (responseWriter != null) {
      final httpMessage =
          await responseWriter.getHttpResponseMessage(httpRequest: httpRequest);
      socket.write(httpMessage);
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
}

// [1] https://api.dart.dev/stable/2.18.6/dart-io/IOSink/close.html

/*
  fatal errors should exit without 
*/