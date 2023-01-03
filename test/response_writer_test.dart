import 'package:test/test.dart';
import 'package:xperi_dart_mock/error.dart';
import 'package:xperi_dart_mock/response_writer.dart';

main() {
  test('ResponseWriterErrorPathNotFound', () {
    Matcher matcher = throwsA(isA<ErrorResponseFilePathNotFound>());
    final responseFilePath = "example/endpoint/errors/do-not-create";
    expect(() => ResponseWriter.builder(responseFilePath), matcher);
  });

  test('ResponseWriterEmptyHttpMessage', () {
    Matcher matcher = throwsA(isA<ErrorResponseWriterEmptyHttpMessage>());
    final responseFilePath =
        "example/errors/endpoint/empty-http-message/empty.data";
    //expect(() => ResponseWriter.builder(responseFilePath), matcher);
  });
}
/*
Checks are performed when Server writes the response

HttpMessage checks
contains a non-empty line 
and ends with  newline
*/