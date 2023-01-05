import 'dart:io';

import 'package:logging/logging.dart';
import 'package:adm_server/log_record_formatter.dart';
import 'package:adm_server/server.dart';

void main(List<String> arguments) async {
  Logger.root.onRecord.listen((r) => LogRecordFormatter.info(r));
  final sourcesDirPath = Directory("").absolute.path;
  final server = Server(sourcesDirPath);
  await server.bind();
  server.listen();
}
