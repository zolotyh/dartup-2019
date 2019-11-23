import 'dart:io';

main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

  var counter = -1;

  await server.listen((request) async {
    counter++;
    final f = first(counter % 2);
    final s = second(counter % 2);
    await Future.wait([f, s]);
    request.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
      ..write('Hello, world')
      ..close();
    print('$counter all is ok');
  }).asFuture();
}

Future first(int multiplier) {
  print('start first');
  return Future.delayed(Duration(milliseconds: (multiplier + 1) * 1000));
}

Future second(int multiplier) {
  print('start second ${multiplier}');
  if (multiplier == 1) {
    throw new Error();
  }
  return Future.delayed(Duration(milliseconds: multiplier * 1000));
}
