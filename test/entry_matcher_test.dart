import 'package:adm_server/adms_request.dart';
import 'package:adm_server/entry_matcher.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

main() {
  test('TestEntryMatcher', () async {
    String entryString;
    YamlMap entry;
    Request shelfRequest;
    AdmsRequest admsRequest;

    // path (v0.0.1)
    entryString = "{'path': 'a'}";
    entry = loadYaml(entryString);
    shelfRequest = Request("GET", Uri.parse("http://127.0.0.1/a"));
    admsRequest = AdmsRequest(shelfRequest);
    expect(await EntryMatcher(entry, admsRequest).isMatch, isTrue);

    // body contains
    entryString = "{'path': 'a', 'body': 'contains!alpha'}";
    entry = loadYaml(entryString);
    shelfRequest =
        Request("POST", Uri.parse("http://127.0.0.1/a"), body: "ok alpha 1");
    admsRequest = AdmsRequest(shelfRequest);
    expect(await EntryMatcher(entry, admsRequest).isMatch, isTrue);

    // body exact, expect isMatch = false
    entryString = "{'path': 'a', 'body': 'alpha'}";
    entry = loadYaml(entryString);
    shelfRequest =
        Request("POST", Uri.parse("http://127.0.0.1/a"), body: "ok alpha 1");
    admsRequest = AdmsRequest(shelfRequest);
    expect(await EntryMatcher(entry, admsRequest).isMatch, isFalse);

    // body exact, expect isMatch = true
    entryString = "{'path': 'a', 'body': 'alpha'}";
    entry = loadYaml(entryString);
    shelfRequest =
        Request("POST", Uri.parse("http://127.0.0.1/a"), body: "alpha");
    admsRequest = AdmsRequest(shelfRequest);
    expect(await EntryMatcher(entry, admsRequest).isMatch, isTrue);
  });

  test('TestEntryProperty', () {
    String property;
    EntryProperty entryProperty;

    property = "exec!alpha-directory";
    entryProperty = EntryProperty(property);
    expect(entryProperty.prefix, isNotNull);
    expect(entryProperty.value, 'alpha-directory');

    property = "alpha-directory";
    entryProperty = EntryProperty(property);
    expect(entryProperty.prefix, isNull);
    expect(entryProperty.value, 'alpha-directory');
  });
}
