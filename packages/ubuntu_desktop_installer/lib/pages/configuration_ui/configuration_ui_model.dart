import 'package:flutter/foundation.dart';

/// Implements the business logic of the WSL Configuration UI page.
class ConfigurationUIModel extends ChangeNotifier {
  /// Creates a advanced setup model.
  ConfigurationUIModel() {
    Listenable.merge([
      _legacyGUI,
      _legacyAudio,
      _advancedIPDetection,
      _wslNews,
      _autoMount,
      _mountFstab
    ]).addListener(notifyListeners);
  }

  /// Whether legacy GUI integration is enabled.
  bool get legacyGUI => _legacyGUI.value;
  final _legacyGUI = ValueNotifier<bool>(false);
  set legacyGUI(bool value) => _legacyGUI.value = value;

  /// Whether legacy audio integration is enabled.
  bool get legacyAudio => _legacyAudio.value;
  final _legacyAudio = ValueNotifier<bool>(false);
  set legacyAudio(bool value) => _legacyAudio.value = value;

  /// Whether advanced IP detection is enabled.
  bool get advancedIPDetection => _advancedIPDetection.value;
  final _advancedIPDetection = ValueNotifier<bool>(false);
  set advancedIPDetection(bool value) => _advancedIPDetection.value = value;

  /// Whether WSL news are enabled.
  bool get wslNews => _wslNews.value;
  final _wslNews = ValueNotifier<bool>(false);
  set wslNews(bool value) => _wslNews.value = value;

  /// Whether auto-mount is enabled.
  bool get autoMount => _autoMount.value;
  final _autoMount = ValueNotifier<bool>(false);
  set autoMount(bool value) => _autoMount.value = value;

  /// Whether `/etc/fstab` will be mounted.
  bool get mountFstab => _mountFstab.value;
  final _mountFstab = ValueNotifier<bool>(false);
  set mountFstab(bool value) => _mountFstab.value = value;

  /// Whether the current input is valid.
  bool get isValid => true;

  /// Loads the UI configuration.
  Future<void> loadUIConfiguration() async {}
}
