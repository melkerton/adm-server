import 'dart:io';
import 'sherpa.dart';
import 'package:yaml/yaml.dart';

// ErrorEndpointResponseIsUndefined
class SherpaHttpResponseIsEmpty with SherpaRenderer implements SherpaMessage {
  @override
  String hint = "Http Response Message can't be empty.";

  @override
  String path = "Unknown.";

  @override
  List<SherpaSection> sections = [];

  SherpaHttpResponseIsEmpty(String path) {
    sections.add(SherpaSection("Add a StartLine.", "HTTP/1.1 200 Ok\\n"));

    render(this);
  }
}
