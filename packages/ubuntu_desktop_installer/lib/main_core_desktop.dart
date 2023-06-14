import 'installer.dart';
import 'routes.dart';

Future<void> main(List<String> args) {
  return runInstallerApp(
    args,
    routes: [
      Routes.locale,
      Routes.keyboard,
      Routes.storage,
    ],
  );
}
