import 'package:flutter/foundation.dart';

/// Implements the business logic of the WSL Advanced Setup page.
class AdvancedSetupModel extends ChangeNotifier {
  /// Creates an advanced setup model.
  AdvancedSetupModel() {
    Listenable.merge([
      _mountLocation,
      _mountOption,
      _enableHostGeneration,
      _enableResolvConfGeneration,
      _enableGUIIntegration,
    ]).addListener(notifyListeners);
  }

  /// Location for the automount.
  String get mountLocation => _mountLocation.value;
  final _mountLocation = ValueNotifier<String>('');
  set mountLocation(String value) => _mountLocation.value = value;

  /// Option passed for the automount.
  String get mountOption => _mountOption.value;
  final _mountOption = ValueNotifier<String>('');
  set mountOption(String value) => _mountOption.value = value;

  /// Whether to enable /etc/hosts re-generation at every start.
  bool get enableHostGeneration => _enableHostGeneration.value;
  final _enableHostGeneration = ValueNotifier<bool>(false);
  set enableHostGeneration(bool value) => _enableHostGeneration.value = value;

  /// Whether to enable /etc/resolv.conf re-generation at every start.
  bool get enableResolvConfGeneration => _enableResolvConfGeneration.value;
  final _enableResolvConfGeneration = ValueNotifier<bool>(false);
  set enableResolvConfGeneration(bool value) =>
      _enableResolvConfGeneration.value = value;

  /// Whether to enable /etc/resolv.conf re-generation at every start.
  bool get enableGUIIntegration => _enableGUIIntegration.value;
  final _enableGUIIntegration = ValueNotifier<bool>(false);
  set enableGUIIntegration(bool value) => _enableGUIIntegration.value = value;

  /// Whether the current input is valid.
  bool get isValid => true;

  /// Loads the advanced setup.
  Future<void> loadAdvancedSetup() async {}
}
