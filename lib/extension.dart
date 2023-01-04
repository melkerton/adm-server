import 'package:logging/logging.dart';

extension LogConfigGuide on Logger {
  void setup(String msg) {
    String delim = '-' * msg.length;
    warning("");
    warning(delim);
    warning(msg);
    warning(delim);
    warning("");
  }
}
