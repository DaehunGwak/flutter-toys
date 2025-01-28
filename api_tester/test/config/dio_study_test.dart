import 'dart:io';

import 'package:api_tester/config/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    skip: true,
    'dio learning test',
    () async {
      // given
      final futures = [
        dio.get(
          'https://tmdb-reverse-proxy-api.vercel.app/v3/movies/upcoming?hello=world&wow=shit,2',
          options: Options(
            headers: {
              HttpHeaders.userAgentHeader: 'api_tester 0.0.1',
              HttpHeaders.acceptHeader: ContentType.text.toString()
            },
          ),
        ),
        dio.get(
            'https://tmdb-reverse-proxy-api.vercel.app/v3/movies/top_rated'),
        dio.get('https://tmdb-reverse-proxy-api.vercel.app/v3/movies/popular'),
      ];

      // when
      final responses = <Response>[];
      for (final request in futures) {
        responses.add(await request);
      }

      // then
      for (final response in responses) {
        print('''
Request:
${response.requestOptions.method} ${'${response.requestOptions.uri.path}${response.requestOptions.uri.query.isEmpty ? '' : '?'}${response.requestOptions.uri.query}'}
Host: ${response.requestOptions.uri.host}
${response.requestOptions.headers.entries.map((entry) => '${entry.key}: ${entry.value}').join('\n')}

Response: ${response.statusCode}, ${response.statusMessage}
${response.headers}
''');
        expect(response.statusCode, equals(200));
      }
    },
  );
}
