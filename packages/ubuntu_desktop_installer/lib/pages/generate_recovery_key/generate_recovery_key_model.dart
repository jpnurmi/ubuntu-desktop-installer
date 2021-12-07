import 'package:flutter/foundation.dart';
import 'package:subiquity_client/subiquity_client.dart';

/// https://github.com/canonical/ubuntu-desktop-installer/issues/34
///
/// See also:
/// * [GenerateRecoveryKeyPage]
class GenerateRecoveryKeyModel extends ChangeNotifier {
  /// Creates the model with the given client.
  GenerateRecoveryKeyModel(this._client) {
    Listenable.merge([
      _recoveryKey,
      _overwrite,
    ]).addListener(notifyListeners);
  }

  final SubiquityClient _client;
  final _recoveryKey = ValueNotifier('/home/ubuntu/recovery.key');
  final _overwrite = ValueNotifier(false);

  /// The current recovery key.
  String get recoveryKey => _recoveryKey.value;
  set recoveryKey(String value) => _recoveryKey.value = value;

  /// Whether empty disk space is overridden.
  bool get overwriteEmptyDiskSpace => _overwrite.value;
  set overwriteEmptyDiskSpace(bool value) => _overwrite.value = value;

  /// Whether the current input is valid.
  bool get isValid => true;

  /// Loads the security key.
  Future<void> loadRecoveryKey() async {}

  /// Saves the security key.
  Future<void> saveRecoveryKey() async {}
}
