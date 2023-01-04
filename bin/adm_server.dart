import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:adm_server/server.dart';

void main(List<String> arguments) async {
  final log = Logger("Main");

  final formatter = LogRecordFormatter();
  Logger.root.onRecord.listen((r) => formatter.info(r));

  final server = Server();
  await server.bind();

  log.info("Listening on http://localhost:${server.port}.");
  server.listen();
}

class LogRecordFormatter {
  final timestampFormat = DateFormat('HH:MM:ss');

  void info(LogRecord record) {
    String message = "${timestampFormat.format(record.time)} "
        "${record.level.name}\t"
        "${record.loggerName}\t"
        "${record.message}";

    print(message);
  }

  void debug(LogRecord record) {
    String message = "${timestampFormat.format(record.time)} "
        "${record.level.name}\t"
        "${record.loggerName}\t"
        "${record.message}";

    print(message);
  }
}
