import 'sherpa.dart';

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
