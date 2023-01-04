import "sherpa.dart";

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
