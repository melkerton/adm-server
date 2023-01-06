import 'package:adm_server/entry_matcher.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

main() {
  test('EntryMatcher', () async {
    String entryString;
    YamlMap entry;
    Request request;

    // path (v0.0.1)
    entryString = "{'path': 'a'}";
    entry = loadYaml(entryString);
    request = Request("GET", Uri.parse("http://127.0.0.1/a"));
    //expect(await EntryMatcher(entry, request).isMatch, isTrue);

    // body contains
    entryString = "{'path': 'a', 'body': 'contains:alpha'}";
    entry = loadYaml(entryString);
    request =
        Request("POST", Uri.parse("http://127.0.0.1/a"), body: "ok alpha 1");
    //expect(await EntryMatcher(entry, request).isMatch, isTrue);
  });
}
