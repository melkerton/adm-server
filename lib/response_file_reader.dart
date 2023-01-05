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
    if (hasHeaders()) {
      if (bodyDelim > 0) {
        responseFileLines.sublist(bodyDelim + 1).join('\n');
      } else {
        return null;
      }
    }

    return responseFileLines.join('\n');
  }

  Map<String, Object> buildHeaders() {
    if (hasHeaders() == false) {
      return {};
    }

    List<String> headerLines = responseFileLines;
    if (bodyDelim > 0) {
      headerLines = responseFileLines.sublist(0, bodyDelim);
    }

    YamlMap headerMap = loadYaml(headerLines.join('\n'));

    // check for special headers first
    if (headerMap.containsKey('x-adms-status-code')) {
      statusCode = headerMap['x-adms-status-code'];
    }

    for (final header in headerMap.entries) {
      headers[header.key] = "${header.value}";
    }

    return headers;
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
