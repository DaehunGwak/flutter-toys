import 'type/method_type.dart';

typedef RequestHeaders = Map<String, dynamic>;

class Request {
  Request({
    required this.method,
    required this.headers,
  });

  final MethodType method;
  final RequestHeaders headers;
}
