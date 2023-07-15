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
  bool get isMatch {
    // path is exact match
    if (matchPath() == false) {
      return false;
    }

    if (matchQuery() == false) {
      return false;
    }

    if (entry.containsKey('body') == true && matchBody() == false) {
      return false;
    }

    return true;
  }

  bool matchBody() {
    // do we have a body to match with?
    String? body = admsRequest.requestBody;

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

  /// if entry does not contain query then request cannot have queryParams
  /// find any reason to return false
  /// extra params in request are not considered (yet?)
  bool matchQuery() {
    if (entry.containsKey('query')) {
      if (entry['query'] is! YamlMap) {
        // TODO throw error or log to stdout to inform user of config error
        return false;
      }

      if (admsRequest.query.isEmpty) {
        return false;
      }

      // expect query to be a map
      YamlMap entryQuery = entry['query'];
      // test each entryQueryKey against requestQueryKey
      for (var key in entryQuery.keys) {
        if (admsRequest.query.containsKey(key) == false) {
          return false;
        }

        // wrap in quotes to compare as string
        if ('${entryQuery[key]}' != '${admsRequest.query[key]}') {
          return false;
        }
      }
    } else if (admsRequest.query.isNotEmpty) {
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
