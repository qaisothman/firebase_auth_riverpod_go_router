import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthConstants {
  const AuthConstants._();
  static const accountExistsWithDifferentCredentialsError =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const appleCom = 'apple.com';
  static const emailScope = 'email';
}
