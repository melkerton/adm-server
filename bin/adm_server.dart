import 'package:adm_server/server_shelf.dart';
import 'package:adm_server/sources.dart';
import 'package:adm_server/system.dart';

void main(List<String> arguments) async {
  // set Directory(""); to use current
  System system = System(arguments);
  Sources sources = Sources(system);

  ServerShelf serverShelf = ServerShelf(system, sources);
  await serverShelf.start();
}
