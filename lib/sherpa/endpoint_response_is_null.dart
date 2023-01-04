import 'dart:io';
import 'sherpa.dart';
import 'package:yaml/yaml.dart';

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
