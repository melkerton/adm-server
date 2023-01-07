import 'package:adm_server/adms_request.dart';
import 'package:yaml/yaml.dart';

class EntryMatcher {
  YamlMap entry;
  AdmsRequest admsRequest;
  EntryMatcher(this.entry, this.admsRequest) {
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

    String? body = await admsRequest.body;

    if (body == null) {
      return false;
    }

    if (matchMethod == 'contains') {
      return body.contains(matchPattern);
    }

    return true;
  }

  /// exact match only
  bool matchPath() {
    if (entry['path'] != admsRequest.path) {
      return false;
    }

    return true;
  }
}

/*
StringMatcher
MapMatcher
*/