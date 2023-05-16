enum AuthResult { aborted, authenticated, failure }

extension AuthResultX on AuthResult {
  bool get isAborted => this == AuthResult.aborted;
  bool get isAuthenticated => this == AuthResult.authenticated;
  bool get isFailure => this == AuthResult.failure;
}
