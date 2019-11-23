import 'dart:io';

main() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

    await for (var request in server) {
        request.response
                ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
                ..write('Hello, world')
                ..close();
    }
}

