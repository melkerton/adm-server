import 'dart:io';

/// creates a minimal clone of HttpRequest to be used internally
/// this allows for testing objects that depend on HttpRequesst
/// to tested directly w/o needing to implement a concrete HttpRequest
///

class AdmsRequest {
  HttpRequest httpRequest;
  AdmsRequest(this.httpRequest);

  Uri get requestedUri => httpRequest.requestedUri;
}
