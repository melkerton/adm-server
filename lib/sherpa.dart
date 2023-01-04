// dart
import 'dart:io';

// package
import 'package:yaml/yaml.dart';

class SherpaSection {
  String label;
  String data;
  SherpaSection(this.label, this.data);
}

abstract class SherpaMessage {
  abstract String hint;
  abstract String path;
  List<SherpaSection> sections = [];
}

mixin SherpaRenderer {
  void render(SherpaMessage message) {
    int repeat = 42;

    // todo find longest line for wrappers
    print('+' * repeat);
    print("Hint: ${message.hint}");
    print("Path: ${message.path}");
    print("Description:\n");

    final tab = "  ";
    for (final section in message.sections) {
      print("$tab- ${section.label}\n");
      print("${tab * 3}${section.data}\n");
    }

    print('-' * repeat);
  }
}

// ErrorEndpointResponseFileNotFound
class SherpaSourcesDirNotFound with SherpaRenderer implements SherpaMessage {
  @override
  String hint = "Sources directory not found.";

  @override
  String path = "Unknown.";

  @override
  List<SherpaSection> sections = [];

  SherpaSourcesDirNotFound(String absSourcesDirPath) {
    path = absSourcesDirPath;
    sections.add(SherpaSection("Create directory.", path));
    render(this);
  }
}

// ErrorEndpointResponseIsUndefined
class SherpaEndpointResponseIsNull
    with SherpaRenderer
    implements SherpaMessage {
  @override
  String hint = "Endpoint entry is missing required Response field.";

  @override
  String path = "Unknown.";

  @override
  List<SherpaSection> sections = [];

  SherpaEndpointResponseIsNull(File endpointFile, YamlMap entry) {
    path = endpointFile.path;

    sections.add(SherpaSection("Response is required.", "missing in $entry"));
    sections.add(SherpaSection("Add to entry.", "response: PATH-TO-RESPONSE"));

    render(this);
  }
}

// ErrorEndpointResponseFileNotFound
class SherpaEndpointResponseFileNotFound
    with SherpaRenderer
    implements SherpaMessage {
  @override
  String hint = "Endpoint entry Response file not found.";

  @override
  String path = "Unknown.";

  @override
  List<SherpaSection> sections = [];

  SherpaEndpointResponseFileNotFound(String responseFilePath) {
    path = responseFilePath;
    sections.add(SherpaSection("Create file.", path));
    render(this);
  }
}

// ErrorResponseWriterEmptyHttpMessage