// dart
import 'dart:io';

// package
import 'package:shelf/shelf_io.dart' as shelf_io;

// local

import 'package:adm_server/system.dart';
import 'package:adm_server/response_builder.dart';
import 'package:adm_server/sources.dart';
import 'package:shelf/shelf.dart';

/// Handle mock requests
///
///
class ServerShelf {
  //static Logger log = Logger("Server");

  Sources sources;
  System system;

  bool verbose = true;

  HttpServer? httpServer;

  /// Default constructor
  ServerShelf(this.system, this.sources);

  Future<void> start() async {
    Handler handler = Pipeline().addHandler(handleRequest);
    httpServer = await shelf_io.serve(handler, system.host, system.port);
    print('Serving at http://${httpServer!.address.host}:${httpServer!.port}');
  }

  Future<void> stop() async {
    if (httpServer == null) {
      return;
    }

    await httpServer!.close();
  }

  Future<Response> handleRequest(Request request) async {
    printReceived(request);

    if (request.url.path.isEmpty) {
      return Response.ok('System is ready!\n');
    }

    final endpoint = sources.getEndpoint();

    if (endpoint == null) {
      return Response.notFound('Endpoint is NULL\n');
    }

    await request.readAsString();
    await request.readAsString();

    ResponseBuilder? builder = await endpoint.getResponseBuilder(request);

    if (builder == null) {
      return Response.notFound("Matching entry not found.\n");
    }

    return await builder.shelfResponse(request);
  }

  Future<void> printReceived(Request request) async {
    print('* ${DateTime.now()} Received request.');
    print("< ${request.method} ${request.requestedUri}");
  }
}
