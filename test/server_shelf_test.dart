import 'package:adm_server/server_shelf.dart';
import 'package:adm_server/sources.dart';
import 'package:adm_server/system.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'helpers.dart';

main() {
  test('TestServerShelfValid', () async {
    System system = validSystem();
    Sources sources = Sources(system);

    ServerShelf serverShelf = ServerShelf(system, sources);

    // check accepting requests
    serverShelf.start().then((_) {
      expect(serverShelf.httpServer, isNotNull);
      serverShelf.stop();
    });

    // trailing '/' required (path)
    Uri uri = Uri.parse("http://127.0.0.1:4202/");
    Request request = Request("GET", uri);
    Response response = await serverShelf.handleRequest(request);
    expect(response.statusCode, equals(200));

    // found match
    uri = Uri.parse("http://127.0.0.1:4202/alpha");
    request = Request("GET", uri);
    response = await serverShelf.handleRequest(request);
    expect(response.statusCode, equals(200));

    // no match found
    uri = Uri.parse("http://127.0.0.1:4202/not-found");
    request = Request("GET", uri);
    response = await serverShelf.handleRequest(request);
    expect(response.statusCode, equals(404));
  });

  test('TestServerShelfNullEndpoint', () async {
    System system = System(["test/data/server/null-endpoint"]);
    Sources sources = Sources(system);
    ServerShelf serverShelf = ServerShelf(system, sources);

    // trailing '/' required (path)
    Uri uri = Uri.parse("http://127.0.0.1:4202/some-path");
    Request request = Request("GET", uri);
    Response response = await serverShelf.handleRequest(request);

    expect(response.statusCode, equals(404));
  });

  test('TestServerWithBody', () async {
    System system = System(["test/data/_valid/index.yaml"]);
    Sources sources = Sources(system);
    ServerShelf serverShelf = ServerShelf(system, sources);
  });
}

/*
TOL

should ServerShelf be constructed with its dependants already? yes
** existance failures are not Errors (Sherpa)

Rules:
  all data-sources MUST include the header x-adms-description

    This also ensures a clear delineation of header and body

  if x-adms-status-code is not set statusCode = 200


Examples
---------------- BEGIN ./headers-only ------------------------
x-adms-description: anything
---------------- END ./headers-only --------------------------

---------------- BEGIN ./with-body ------------------------
x-adms-description: anything
x-adms-status-code: 201

{"id": 0}
---------------- END ./with-body --------------------------


*/
