import 'package:adm_server/server_shelf.dart';
import 'package:adm_server/sources.dart';
import 'package:adm_server/system.dart';
import 'package:shelf/shelf.dart';
//import 'package:http/http.dart';
import 'package:test/test.dart';

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
    Response response = serverShelf.handleRequest(request);

    expect(response.statusCode, equals(200));
  });

  test('TestServerShelfNullEndpoint', () {
    System system = System("test/data/server/null-endpoint");
    Sources sources = Sources(system);
    ServerShelf serverShelf = ServerShelf(system, sources);

    // trailing '/' required (path)
    Uri uri = Uri.parse("http://127.0.0.1:4202/some-path");
    Request request = Request("GET", uri);
    Response response = serverShelf.handleRequest(request);

    expect(response.statusCode, equals(200));
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
