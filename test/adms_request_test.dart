import 'package:adm_server/adms_request.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

main() {
  test('TestAdmsRequest', () async {
    Request request;
    AdmsRequest admsRequest;
    String? body;

    // GET no body
    request = Request('GET', Uri.parse("http://locahost/path?id=1"));
    admsRequest = AdmsRequest(request);
    expect(await admsRequest.body, isNull);
    expect(admsRequest.path, "path");

    // POST with body
    request =
        Request('POST', Uri.parse("http://locahost/path?id=2"), body: "ALPHA");
    admsRequest = AdmsRequest(request);
    body = await admsRequest.body;
    expect(body, isNotNull);
    expect(body, equals('ALPHA'));
  });
}
