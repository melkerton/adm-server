import 'dart:io';

// dart

// package
import 'package:shelf/shelf_io.dart' as shelf_io;

// local

import 'package:adm_server/endpoint.dart';
import 'package:adm_server/system.dart';
import 'package:logging/logging.dart';
import 'package:adm_server/response_writer.dart';
import 'package:adm_server/sources.dart';
import 'package:shelf/shelf.dart';

/// Handle mock requests
///
///
class ServerShelf {
  //static Logger log = Logger("Server");

  Sources sources;
  System system;

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

  Response handleRequest(Request request) {
    print("HandleRequest ${request.requestedUri}");
    final endpoint = sources.getEndpoint();

    if (endpoint == null) {
      return Response.notFound('Endpoint is NULL\n');
    }

    //ResponseWriter? responseWriter = endpoint.getResponseWriter(request);

    /*
    Server.log.info("Found Endpoint ${endpoint.baseName}.");

    await sendRaw(httpRequest, responseWriter);
    */

    print("HandleRequest valid endpoint");
    return Response.ok('Request for "${request.url}"\n');
  }
}
