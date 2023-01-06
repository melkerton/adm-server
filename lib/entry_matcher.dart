import 'package:shelf/shelf.dart';
import 'package:yaml/yaml.dart';

class EntryMatcher {
  YamlMap entry;
  Request request;
  EntryMatcher(this.entry, this.request) {
    // body contains
  }

  // find negative examples
  // all set matchers must match
  // if nothing fails return true
  Future<bool> get isMatch async {
    // path is exact match
    if (matchPath() == false) {
      return false;
    }

    if (entry.containsKey('body') == true && await matchBody() == false) {
      return false;
    }

    return true;
  }

  Future<bool> matchBody() async {
    List<String> parts = entry['body'].split(":");
    String matchMethod = parts[0];
    String matchPattern = parts.sublist(1).join("");

    String body = await request.readAsString();

    if (entry.containsKey('debug')) {
      for (final header in request.headers.entries) {
        print("< ${header.key}: ${header.value}");
      }

      if (body.isNotEmpty) {
        print("<\n< ${body.trimRight()}");
      }

      print('');
    }

    if (body.isEmpty) {
      throw Exception('body unexpectedly empty');
    }

    if (matchMethod == 'contains') {
      return body.contains(matchPattern);
    }

    return true;
  }

  bool matchPath() {
    if (entry['path'] != request.url.path) {
      return false;
    }

    return true;
  }
}
