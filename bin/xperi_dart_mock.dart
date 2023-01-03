import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:xperi_dart_mock/server.dart';

void main(List<String> arguments) async {
  final log = Logger("Main");

  final timestampFormat = DateFormat('HH:MM:s');

  Logger.root.onRecord.listen((record) {
    String message = "${timestampFormat.format(record.time)} "
        "${record.level.name}\t"
        "${record.message}";

    print(message);
  });

  final server = Server();
  await server.bind();

  log.info("Listening on http://localhost:${server.port}.");
  server.listen();
}
