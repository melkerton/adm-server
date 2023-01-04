// dart
import 'dart:io';

// package

// local
export 'endpoint_response_file_not_found.dart';
export 'endpoint_response_is_null.dart';
export 'sources_dir_not_found.dart';

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


// ErrorResponseWriterEmptyHttpMessage