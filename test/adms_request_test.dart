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
    expect(admsRequest.requestBody, isNull);
    expect(admsRequest.path, "path");

    // POST with body, CONTEXT expects requestBody in admsRequest
    request = Request('POST', Uri.parse("http://locahost/path?id=2"));
    admsRequest = AdmsRequest(request, requestBody: "ALPHA");
    body = admsRequest.requestBody;
    expect(body, isNotNull);
    expect(body, equals('ALPHA'));
  });
}
