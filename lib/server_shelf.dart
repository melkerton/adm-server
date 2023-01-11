// dart
import 'dart:io';

// package
import 'package:adm_server/adms_request.dart';
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

  Future<Response> handleRequest(Request shelfRequest) async {
    String? requestBody;
    if (shelfRequest.isEmpty == false) {
      requestBody = await shelfRequest.readAsString();
    }

    AdmsRequest admsRequest =
        AdmsRequest(shelfRequest, requestBody: requestBody);

    printReceived(admsRequest);

    if (shelfRequest.url.path.isEmpty) {
      return Response.ok('System is ready!\n');
    }

    final endpoint = sources.getEndpoint();

    if (endpoint == null) {
      return Response.notFound('Endpoint is NULL\n');
    }

    ResponseBuilder? builder = await endpoint.getResponseBuilder(admsRequest);

    if (builder == null) {
      String msg = "Matching entry not found.";
      print('> Matched: None\n');
      return Response.notFound("$msg\n");
    }

    print('> Matched: ${builder.label}\n');
    return await builder.shelfResponse(shelfRequest);
  }

  Future<void> printReceived(AdmsRequest admsRequest) async {
    print('* ${DateTime.now()} Received request.');
    print("< ${admsRequest.shelfRequest.method} ${admsRequest.path}");

    Request shelfRequest = admsRequest.shelfRequest;
    for (final header in shelfRequest.headers.entries) {
      print("< ${header.key}: ${header.value}");
    }

    String? body = admsRequest.requestBody;
    if (body != null && body.isNotEmpty) {
      print("<\n< ${body.trimRight()}");
    }

    print('');
  }
}
