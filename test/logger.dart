import 'package:logging/logging.dart';

class TestLogger {
  static bool recording = false;

  static void record() {
    if (recording == true) {
      return;
    }

    // defaults to Level.INFO
    // Logger.root.level = Level.ALL;
    //
    // need to review this, public dependence not great

    TestLogger.recording = true;

    Logger.root.onRecord.listen((record) {
      String message = "${record.level.name}: "
          "${record.time}:"
          "${record.message}";

      // mask severe at least
      if (record.level.value > Level.INFO.value) {
        //return;
      }

      print(message);
      //print("${record.level.value} ${Level.INFO.value}");
    });
  }
}
