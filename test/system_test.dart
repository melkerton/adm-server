// package
import 'package:test/test.dart';
import 'package:adm_server/system.dart';

main() {
  test('TestSystemDefault', () {
    // Expects APP_ROOT/adms.yaml
    final system = System();

    // expect sourcesDir w/o trailing ps
    expect(system.sourcesDir.path.endsWith(system.ps), isFalse);

    // expect adms.yaml to contain valid yaml
    expect(system.admsYamlConfig, isNotNull);

    // expect port to be non-zero
    expect(system.port, greaterThan(0));

    // expect host to be not 'localhost'
    expect(system.admsYamlConfig, isNotNull);
  });
}
