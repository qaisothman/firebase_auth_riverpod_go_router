import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/l10n/arb/app_localizations.dart';
import 'package:flutter/foundation.dart' show immutable;


const Map<String, AuthError> _authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
  'wrong-password': AuthErrorWrongPassword(),
  'too-many-requests': AuthErrorTooManyRequests(),
  'credential-already-in-use': AuthErrorCredentialAlreadyInUse(),
  'session-expired': AuthErrorSessionExpired(),
};

MapEntry<String, String> parseAuthErrorTextsFromCode({
  required String code,
  required AppLocalizations l10n,
}) {
  switch (code) {
    case 'user-not-found':
      return MapEntry(
        l10n.userNotFoundTitle,
        l10n.userNotFoundMessage,
      );

    case 'wrong-password':
      return MapEntry(
        l10n.wrongPasswordTitle,
        l10n.wrongPasswordMessage,
      );
    case 'weak-password':
      return MapEntry(
        l10n.weakPasswordTitle,
        l10n.weakPasswordMessage,
      );
    case 'invalid-email':
      return MapEntry(
        l10n.invalidEmailTitle,
        l10n.invalidEmailMessage,
      );

    case 'operation-not-allowed':
      return MapEntry(
        l10n.operationNotAllowedTitle,
        l10n.operationNotAllowedMessage,
      );
    case 'email-already-in-use':
      return MapEntry(
        l10n.emailAlreadyInUseTitle,
        l10n.emailAlreadyInUseMessage,
      );
    case 'requires-recent-login':
      return MapEntry(
        l10n.requiresRecentLoginTitle,
        l10n.requiresRecentLoginMessage,
      );
    case 'no-current-user':
      return MapEntry(
        l10n.noCurrentUserTitle,
        l10n.noCurrentUserMessage,
      );

    case 'too-many-requests':
      return MapEntry(
        l10n.tooManyRequestsTitle,
        l10n.tooManyRequestsMessage,
      );

    case 'credential-already-in-use':
      return MapEntry(
        l10n.credentialAlreadyInUseTitle,
        l10n.credentialAlreadyInUseMessage,
      );

    case 'session-expired':
      return MapEntry(
        l10n.sessionExpiredTitle,
        l10n.sessionExpiredMessage,
      );

    default:
      return MapEntry(
        l10n.unknownAuthErrorTitle,
        l10n.unknownAuthErrorMessage,
      );
  }
}

@immutable
abstract class AuthError {
  const AuthError({
    this.code = 'unknown',
  });

  /// factory constructor to create an [AuthError]
  /// from a [FirebaseAuthException]
  factory AuthError.from(FirebaseAuthException exception) =>
      _authErrorMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();

  final String code;
}

/// error type thrown when an unknown error [AuthError] occurs
@immutable
class AuthErrorUnknown extends AuthError {
  /// constructor for [AuthErrorUnknown]
  const AuthErrorUnknown() : super();
}

/// error type thrown when no current [User] logged in
@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          code: 'no-current-user',
        );
}

/// error type thrown when a [User]  needs to re-login because of
/// the [User] token has expired
@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          code: 'requires-recent-login',
        );
}

/// error type thrown when a [User]  doesn't have permission to perform
/// specific operation
@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          code: 'operation-not-allowed',
        );
}

/// error type thrown when a [User]  account is not found on the server
@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          code: 'user-not-found',
        );
}

@immutable
class AuthErrorWrongPassword extends AuthError {
  const AuthErrorWrongPassword()
      : super(
          code: 'wrong-password',
        );
}

/// error type thrown when a user password is too weak
@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          code: 'weak-password',
        );
}

/// error type thrown when a [User]  email is invalid
@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          code: 'invalid-email',
        );
}

/// error type thrown when a [User] email is already in use
@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          code: 'email-already-in-use',
        );
}

@immutable
class AuthErrorTooManyRequests extends AuthError {
  const AuthErrorTooManyRequests()
      : super(
          code: 'too-many-requests',
        );
}

@immutable
class AuthErrorCredentialAlreadyInUse extends AuthError {
  const AuthErrorCredentialAlreadyInUse()
      : super(
          code: 'credential-already-in-use',
        );
}

@immutable
class AuthErrorSessionExpired extends AuthError {
  const AuthErrorSessionExpired()
      : super(
          code: 'session-expired',
        );
}
