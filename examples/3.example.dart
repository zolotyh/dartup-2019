import 'dart:async';
import 'dart:io';

main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

  var counter = -1;

  await server.listen((request) async {
    counter++;
    await runZoned(
      () async {
        await proceed(counter % 2);
      },
      zoneValues: {'counter': counter},
      zoneSpecification: ZoneSpecification(
          handleUncaughtError: (zone, delegate, zone2, error, trace) {
        zone.print('error');
      }),
    );

    request.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
      ..write('Hello, world')
      ..close();

    print('$counter all is ok');
  }).asFuture();
}

Future proceed(int multiplier) {
  print('start ${multiplier} ${Zone.current['counter']}');

  if (multiplier == 1) {
      throw new Error();
  }
  return Future.delayed(Duration(milliseconds: multiplier + 1 * 1000));
}
