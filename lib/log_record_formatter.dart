import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class LogRecordFormatter {
  static void info(LogRecord record) {
    final timestampFormat = DateFormat('HH:MM:ss');
    String message = "${timestampFormat.format(record.time)} "
        "${record.loggerName}\t"
        "${record.level.name}\t"
        "${record.message}";

    print(message);
  }

  static void debug(LogRecord record) {
    final timestampFormat = DateFormat('HH:MM:ss');
    final message = [
      timestampFormat.format(record.time),
      record.level.name.substring(0, 4),
      record.loggerName.substring(0, 5),
      record.message
    ];

    print(message.join("\t"));
  }

  static get defaultDateFormat => DateFormat('HH:MM:ss');
}
