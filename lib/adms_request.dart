import 'package:shelf/shelf.dart';

/// wrapper for Request
/// make body available
class AdmsRequest {
  Request shelfRequest;
  String? storedBody;
  bool _bodyHasBeenConsumed = false;

  AdmsRequest(this.shelfRequest);

  Future<String?> get body async {
    if (shelfRequest.contentLength == 0) {
      return null;
    }

    if (_bodyHasBeenConsumed == false) {
      storedBody = await shelfRequest.readAsString();
      _bodyHasBeenConsumed = true;
    }

    return storedBody;
  }

  String get path => shelfRequest.url.path;
}
