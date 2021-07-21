import 'package:crypt/crypt.dart';

/// Supported encryption algorithms.
enum Algorithm {
  /// SHA-256
  sha256,

  /// SHA-512
  sha512,
}

/// Encrypts a password.
String encryptPassword(
  String password, {
  Algorithm algorithm = Algorithm.sha512,
  String? salt,
}) {
  assert(password.isNotEmpty);
  switch (algorithm) {
    case Algorithm.sha256:
      return Crypt.sha256(password, salt: salt).toString();
    case Algorithm.sha512:
      return Crypt.sha512(password, salt: salt).toString();
  }
}
