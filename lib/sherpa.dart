// dart
import 'dart:io';

// package
import 'package:yaml/yaml.dart';

class SherpaSection {
  String label;
  String data;
  SherpaSection(this.label, this.data);
}

class SherpaMessage {
  String get hint => "undefined";
  FileSystemEntity referenceFile;

  String get absPath => referenceFile.absolute.path;

  List<SherpaSection> sections = [];
  SherpaMessage(this.referenceFile);
  void render(SherpaMessage message) {
    int repeat = 42;

    // todo find longest line for wrappers
    print('+' * repeat);
    print("Hint: ${message.hint}");
    print("Path: ${message.absPath}");
    print("Description:\n");

    final tab = "  ";
    for (final section in message.sections) {
      print("$tab- ${section.label}\n");
      print("${tab * 3}${section.data}\n");
    }

    print('-' * repeat);
  }
}

/// child clases
class SherpaEndpointIndexFileNotFound extends SherpaMessage {
  SherpaEndpointIndexFileNotFound(super.referenceFile) {
    sections.add(SherpaSection(
        "Create an index.yaml file", "touch $absPath/index.yaml"));
    render(this);
  }
}

class SherpaEndpointResponseFileNotFound extends SherpaMessage {
  SherpaEndpointResponseFileNotFound(super.referenceFile) {
    sections.add(SherpaSection("Create file.", "touch $absPath"));
    render(this);
  }
}

class SherpaEndpointResponseIsNull extends SherpaMessage {
  SherpaEndpointResponseIsNull(super.referenceFile, YamlMap entry) {
    sections.add(SherpaSection("Response is required.", "missing in $entry"));
    sections.add(SherpaSection("Add to entry.", "response: PATH-TO-RESPONSE"));
    render(this);
  }
}

class SherpaHttpResponseIsEmpty extends SherpaMessage {
  SherpaHttpResponseIsEmpty(super.referenceFile) {
    sections.add(SherpaSection("Add a StartLine.", "HTTP/1.1 200 Ok\\n"));
    render(this);
  }
}

class SherpaSourcesDirNotFound extends SherpaMessage {
  SherpaSourcesDirNotFound(super.referenceFile) {
    sections.add(SherpaSection("Create directory.", absPath));
    render(this);
  }
}
