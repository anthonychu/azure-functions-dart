import 'dart:io';

Future main() async {
  var port = Platform.environment['FUNCTIONS_CUSTOMHANDLER_PORT'] ?? '4040';
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    int.parse(port),
  );
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    switch (request.uri.path) {
      case '/api/hello':
        await helloHandler(request);
        break;
      case '/api/version':
        await versionHandler(request);
        break;
      default:
        await defaultHandler(request);
        break;
    }
  }
}

Future helloHandler(HttpRequest request) async {
  var name = request.uri.queryParameters['name'] ?? 'world';
  request.response.write('Hello, ${name}!');
  await request.response.close();
}

Future versionHandler(HttpRequest request) async {
  request.response.write('Dart version ${Platform.version}');
  await request.response.close();
}

Future defaultHandler(HttpRequest request) async {
  request.response.statusCode = 404;
  await request.response.close();
}