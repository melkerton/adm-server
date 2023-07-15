import 'package:shelf/shelf.dart';

/// wrapper for Request
/// make body available
class AdmsRequest {
  Request shelfRequest;
  String? requestBody;

  AdmsRequest(this.shelfRequest, {this.requestBody});

  String get method => shelfRequest.method.toLowerCase();
  String get path => shelfRequest.url.path;
  Map<String, String> get query => shelfRequest.url.queryParameters;
}

/*

    if (shelfRequest.isEmpty) {
      print('AdmsRequest shelfRequestIsEmpty');
      return null;
    }

    print('AdmsRequest ${shelfRequest.contentLength} ${storedBody == null}');
    if (_bodyHasBeenConsumed == true) {
      print('AdmsRequest consumed');
      return storedBody;
    }

*/