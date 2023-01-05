// dart
import 'dart:io';

// package
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

class System {
  String ps = Platform.pathSeparator;

  Logger log = Logger('Config');
  int port = 0;
  String host = "localhost";

  late Directory sourcesDir;
  YamlMap? admsYamlConfig;

  System({String? sourcesDirPath}) {
    // get sourcesDir w/o training ps
    var path = Directory(sourcesDirPath ?? "").absolute.path;
    if (path.endsWith(ps)) {
      path = path.substring(0, path.lastIndexOf(ps));
    }
    sourcesDir = Directory(path);

    loadConfig();
  }

  void loadConfig() {
    final admsConfigFile = File("${sourcesDir.path}/adms.yaml");

    if (admsConfigFile.existsSync() == false) {
      return;
    }

    // let yaml error perpetuate
    admsYamlConfig = loadYaml(admsConfigFile.readAsStringSync());

    // empty config
    if (admsYamlConfig!.isEmpty) {
      return;
    }

    // no server section
    if (admsYamlConfig!.containsKey('server') == false) {
      return;
    }

    YamlMap server = admsYamlConfig!['server'];

    // port
    if (server.containsKey('port')) {
      port = server['port'];
    }

    // host
    if (server.containsKey('host')) {
      host = server['host'];
    }
  }
}
