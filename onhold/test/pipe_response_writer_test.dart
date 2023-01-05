@Skip("PipeResponse")
import 'dart:io';

import 'package:adm_server/adm_server.dart';
import 'package:adm_server/pipe_response_writer.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

import 'helpers.dart';

main() {
  setUp(() {
    TestLogger.record();
  });
  test('PipeResponse', () async {
    //
    var responseFile = File("example/pipe-beta.py");
    var pr = PipeResponseWriter(responseFile: responseFile);

    var httpMessage = await pr.getHttpResponseMessage();
    //print(httpMessage);
  });

  test('PipeResponseServerContext', () async {
    /*
    final server = Server();
    await server.bind();

    server.listen();

    final uri = Uri.parse("http://localhost:7170/beta");
    final response = await Client().get(uri);

    print(response.body);

    //
    server.close();
    */
  });
}
