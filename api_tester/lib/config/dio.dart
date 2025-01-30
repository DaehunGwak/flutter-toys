import 'dart:io';

import 'package:dio/dio.dart';

final dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.putIfAbsent(
          HttpHeaders.userAgentHeader,
          () => 'ordi api_tester',
        );
        options.headers.putIfAbsent(
          HttpHeaders.acceptHeader,
          () => ContentType.json.toString(),
        );
        return handler.next(options);
      },
    ),
  );
