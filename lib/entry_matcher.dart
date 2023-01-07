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
    // do we have a body to match with?
    String? body = await admsRequest.body;
    if (body == null) {
      return false;
    }

    EntryProperty entryProperty = EntryProperty(entry['body']);

    String matchMethod = entryProperty.prefix ?? 'exact';

    switch (matchMethod) {
      case 'exact':
        return entryProperty.value == body;
      case 'contains':
        return body.contains(entryProperty.value);
      default:
        return false;
    }
  }

  /// exact match only
  bool matchPath() {
    if (entry['path'] != admsRequest.path) {
      return false;
    }

    return true;
  }
}

class EntryProperty {
  static String delim = '!';
  String? prefix;
  String value;
  int prefixMaxLength = 16;

  EntryProperty(this.value) {
    // test pattern
    int indexOfDelim = value.indexOf(EntryProperty.delim);

    // is a prefix
    if (indexOfDelim > -1 && indexOfDelim < prefixMaxLength) {
      prefix = value.substring(0, indexOfDelim);
      value = value.substring(indexOfDelim + 1);
    }
  }
}

/*
StringMatcher
MapMatcher
*/