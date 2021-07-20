import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:subiquity_client/subiquity_client.dart';

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

  /// Determine the strength of the password.
  PasswordStrength? get passwordStrength {
    final strongPassword = RegExp(r'(?=.*?[#?!@$%^&*-])');
    final averagePassword = RegExp(r'(^.*(?=.{6,})(?=.*\d).*$)');

    if (strongPassword.hasMatch(password) && password.length > 8) {
      return PasswordStrength.strongPassword;
    }
    if (averagePassword.hasMatch(password)) {
      return PasswordStrength.averagePassword;
    }
    if (password.isNotEmpty && password.length > 1) {
      return PasswordStrength.weakPassword;
    }
    return null;
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
  Future<void> saveProfileSetup() async {
    return _client.setIdentity(
      _identity.value.copyWith(cryptedPassword: encryptPassword(password)),
    );
  }

  static final _encryptionIV = encrypt.IV.fromLength(16);
  static encrypt.Encrypter get _encrypter =>
      encrypt.Encrypter(encrypt.AES(encrypt.Key.fromLength(32)));

  /// Encrypts a password.
  @visibleForTesting
  static String encryptPassword(String password) {
    assert(password.isNotEmpty);
    return _encrypter.encrypt(password, iv: _encryptionIV).base64;
  }

  /// Decrypts a password.
  @visibleForTesting
  static String decryptPassword(String encryptedPassword) {
    assert(encryptedPassword.isNotEmpty);
    return _encrypter.decrypt64(encryptedPassword, iv: _encryptionIV);
  }
}

/// The strength of the password
enum PasswordStrength {
  /// Representing weak password
  weakPassword,

  /// Representing an average password
  averagePassword,

  /// Representing a strong password
  strongPassword
}
