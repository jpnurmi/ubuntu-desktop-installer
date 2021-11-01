import 'package:safe_change_notifier/safe_change_notifier.dart';

enum ConnectMode {
  none,
  ethernet,
  wifi,
  hiddenWifi,
}

abstract class ConnectModel extends SafeChangeNotifier {
  bool get canConnect;
  bool get canContinue;
  bool get isActive;
  bool get isBusy;
  ConnectMode? get connectMode;
  void init();
  Future<void> connect();
}

class NoConnectModel extends ConnectModel {
  @override
  bool get canConnect => false;

  @override
  bool get canContinue => true;

  @override
  bool get isActive => false;

  @override
  bool get isBusy => false;

  @override
  ConnectMode? get connectMode => ConnectMode.none;

  @override
  void init() {}

  @override
  Future<void> connect() {
    throw UnsupportedError('Nothing to connect');
  }
}
