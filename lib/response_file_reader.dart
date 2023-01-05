import 'package:yaml/yaml.dart';

class ResponseFileReader {
  List<String> responseFileLines;

  int bodyDelim = -1;

  String? body;
  Map<String, Object> headers = {};
  int statusCode = 200;

  // responseFileLines.length > 0 by Builder
  ResponseFileReader(this.responseFileLines) {
    bodyDelim = getBodyDelim();
    headers = buildHeaders();
    body = buildBody();
  }

  String? buildBody() {
    if (bodyDelim < 0) {
      return responseFileLines.join('\n');
    }

    responseFileLines.sublist(bodyDelim).join('\n');
    return null;
  }

  Map<String, Object> buildHeaders() {
    if (hasHeaders() == false) {
      return {};
    }

    List<String> headerLines = responseFileLines;
    if (bodyDelim > -1) {
      //headerLines = responseFileLines.sublist(0, bodyDelim - 1);
    }

    /*
      0 = first line ... not usefule
      1 = seond line ... first possible for empty
    */

    YamlMap headerMap = loadYaml(headerLines.join('\n'));

    // check for special headers first
    if (headerMap.containsKey('x-adms-status-code')) {
      statusCode = headerMap['x-adms-status-code'];
    }

    for (final header in headerMap.entries) {
      headers[header.key] = "${header.value}";
    }
    return {};
  }

  int getBodyDelim() {
    int test = responseFileLines.indexWhere((line) => line.isEmpty);
    if (test > -1) {
      return test;
    }

    return -1;
  }

  bool hasHeaders() {
    var parts = responseFileLines[0].split(':');

    // does not contain ':'
    if (parts.length == 1) {
      return false;
    }

    // TODO validate a first line like {"id": 1}

    return true;
  }
}
