import 'package:flutter/foundation.dart';
import 'package:subiquity_client/subiquity_client.dart';

import '../../utils.dart';
export '../../utils.dart' show PasswordStrength;

/// Implements the business logic of the WSL Profile Setup page.
class ProfileSetupModel extends ChangeNotifier {
  /// Creates a profile setup model.
  ProfileSetupModel(this._client) {
    Listenable.merge([
      _identity,
      _password,
      _showAdvanced,
    ]).addListener(notifyListeners);
  }

  final SubiquityClient _client;
  final _identity = ValueNotifier<IdentityData>(IdentityData());

  /// The username for the profile.
  String get username => _identity.value.username ?? '';
  set username(String value) {
    _identity.value = _identity.value.copyWith(username: value);
  }

  /// The password for the profile.
  String get password => _password.value;
  final _password = ValueNotifier<String>('');
  set password(String value) => _password.value = value;

  /// Estimates the strength of the password.
  PasswordStrength get passwordStrength {
    return estimatePasswordStrength(password);
  }

  /// Whether to show the advanced options.
  bool get showAdvancedOptions => _showAdvanced.value;
  final _showAdvanced = ValueNotifier<bool>(false);
  set showAdvancedOptions(bool value) => _showAdvanced.value = value;

  /// Whether the current input is valid.
  bool get isValid => username.isNotEmpty && password.isNotEmpty;

  /// Loads the profile setup.
  Future<void> loadProfileSetup() async {
    return _client.identity().then((identity) => _identity.value = identity);
  }

  /// Saves the profile setup.
  Future<void> saveProfileSetup({@visibleForTesting String? salt}) async {
    final cryptedPassword = encryptPassword(password, salt: salt);
    return _client.setIdentity(
      _identity.value.copyWith(cryptedPassword: cryptedPassword),
    );
  }
}
