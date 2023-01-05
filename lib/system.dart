// dart
import 'dart:io';

// package
import 'package:yaml/yaml.dart';

class System {
  YamlMap? admsYamlConfig;
  String sourcesDirPath;

  // server settings
  int port = 0;
  String host = "localhost";

  System(this.sourcesDirPath) {
    // clean path expect no trailing ps
    if (sourcesDirPath.endsWith(ps)) {
      sourcesDirPath =
          sourcesDirPath.substring(0, sourcesDirPath.lastIndexOf(ps));
    }
    loadConfig();
  }

  // getters

  Directory get sourcesDir {
    return Directory(absSourcesDirPath);
  }

  String get absSourcesDirPath => Directory(sourcesDirPath).absolute.path;

  String get ps => Platform.pathSeparator;

  // methods

  void loadConfig() {
    final admsConfigFile = File("$absSourcesDirPath/adms.yaml");

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
