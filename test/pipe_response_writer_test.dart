import 'dart:io';

import 'package:adm_server/pipe_response_writer.dart';
import 'package:test/test.dart';

main() {
  test('PipeResponse', () async {
    //
    var responseFile = File("example/pipe-beta.py");
    var pr = PipeResponseWriter(responseFile: responseFile);

    var httpMessage = await pr.getHttpResponseMessage();
    print(httpMessage);
  });
}
