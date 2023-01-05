// package
import 'package:test/test.dart';
import 'package:adm_server/system.dart';

main() {
  test('TestSystem', () {
    final system = System("test/data/_valid/");

    // expect sourcesDir w/o trailing ps
    expect(system.sourcesDirPath.endsWith(system.ps), isFalse);

    // expect adms.yaml to contain valid yaml
    expect(system.admsYamlConfig, isNotNull);

    // expect port to be set
    expect(system.port, equals(4202));

    // expect host to be set
    expect(system.host, equals("127.0.0.1"));
  });
}
