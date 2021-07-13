import 'package:flutter/foundation.dart';

import '../../services.dart';

/// Implements the business logic of the WSL Profile Setup page.
class ProfileSetupModel extends ChangeNotifier {
  /// Creates a profile setup model.
  ProfileSetupModel({required UserService service}) : _service = service {
    Listenable.merge([
      _username,
      _password,
      _confirmedPassword,
      _showAdvanced,
    ]).addListener(notifyListeners);
  }

  final UserService _service;

  /// The username for the profile.
  String get username => _username.value;
  final _username = ValueNotifier<String>('');
  set username(String value) {
    _service.storeUsername(value);
    _username.value = value;
  }

  /// The password for the profile.
  String get password => _password.value;
  final _password = ValueNotifier<String>('');
  set password(String value) => _password.value = value;

  /// The confirmed password for validation purposes.
  String get confirmedPassword => _confirmedPassword.value;
  final _confirmedPassword = ValueNotifier<String>('');
  set confirmedPassword(String value) => _confirmedPassword.value = value;

  /// Whether to show the advanced options.
  bool get showAdvancedOptions => _showAdvanced.value;
  final _showAdvanced = ValueNotifier<bool>(false);
  set showAdvancedOptions(bool value) => _showAdvanced.value = value;

  /// Whether the current input is valid.
  bool get isValid =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      password == confirmedPassword;

  /// Loads the profile setup.
  Future<void> loadProfileSetup() async {
    _username.value = await _service.fetchUsername();
  }
}
