// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_auth_riverpod_go_router/product/auth/models/auth_error.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/models/user_model.dart';
import 'package:flutter/foundation.dart' show immutable;

enum AuthProvider {
  email,
  google,
  apple,
  phone,
}

@immutable
abstract class AuthState {
  final bool isLoading;
  final AuthError? error;

  bool get hasError => error != null;

  const AuthState({
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AuthError? error,
    bool? isLoading,
  });
}

class AuthStateUnknown extends AuthState {
  const AuthStateUnknown({
    super.error,
    super.isLoading,
  });

  @override
  AuthState copyWith({
    AuthError? error,
    bool? isLoading,
  }) {
    return AuthStateUnknown(
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthStateInRegister extends AuthState {
  const AuthStateInRegister({
    required this.firebaseUser,
    this.localUser,
    super.error,
    super.isLoading,
  });

  final User? firebaseUser;
  final UserData? localUser;

  @override
  AuthStateInRegister copyWith({
    User? firebaseUser,
    UserData? localUser,
    bool? isLoading,
    AuthError? error,
  }) {
    return AuthStateInRegister(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      localUser: localUser ?? this.localUser,
    );
  }

  @override
  bool operator ==(covariant AuthStateInRegister other) {
    if (identical(this, other)) return true;

    return other.firebaseUser == firebaseUser &&
        other.emailVerified == emailVerified &&
        other.error == error &&
        other.isLoading == isLoading &&
        other.localUser == localUser;
  }

  @override
  int get hashCode =>
      firebaseUser.hashCode ^
      emailVerified.hashCode ^
      error.hashCode ^
      isLoading.hashCode ^
      localUser.hashCode;
}

class AuthStateInProfileCompletion extends AuthState {
  final User? firebaseUser;
  final UserData? localUser;
  final bool? emailVerified;

  const AuthStateInProfileCompletion({
    this.firebaseUser,
    this.localUser,
    this.emailVerified,
    super.error,
    super.isLoading,
  });

  @override
  AuthStateInProfileCompletion copyWith({
    User? firebaseUser,
    UserData? localUser,
    bool? emailVerified,
    bool? isLoading,
    AuthError? error,
  }) {
    return AuthStateInProfileCompletion(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      localUser: localUser ?? this.localUser,
      emailVerified: emailVerified,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(covariant AuthStateInProfileCompletion other) {
    if (identical(this, other)) return true;

    return other.firebaseUser == firebaseUser &&
        other.localUser == localUser &&
        other.error == error &&
        other.isLoading == isLoading &&
        other.emailVerified == emailVerified;
  }

  @override
  int get hashCode =>
      firebaseUser.hashCode ^
      localUser.hashCode ^
      error.hashCode ^
      isLoading.hashCode ^
      emailVerified.hashCode;
}

class AuthStateProfileCompleted extends AuthState {
  final UserData? localUser;
  final User? firebaseUser;

  const AuthStateProfileCompleted({
    required this.localUser,
    required this.firebaseUser,
    super.error,
    super.isLoading,
  });

  @override
  AuthStateProfileCompleted copyWith({
    UserData? localUser,
    User? firebaseUser,
    bool? isLoading,
    AuthError? error,
  }) {
    return AuthStateProfileCompleted(
      localUser: localUser ?? this.localUser,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      firebaseUser: firebaseUser ?? this.firebaseUser,
    );
  }

  @override
  bool operator ==(covariant AuthStateProfileCompleted other) {
    if (identical(this, other)) return true;

    return other.localUser == localUser &&
        other.error == error &&
        other.isLoading == isLoading &&
        other.firebaseUser == firebaseUser;
  }

  @override
  int get hashCode =>
      localUser.hashCode ^
      error.hashCode ^
      isLoading.hashCode ^
      firebaseUser.hashCode;
}

extension AuthStateX on AuthState {
  bool get isLoading => this.isLoading;
  bool get hasError => this.hasError;
  AuthError? get error => this.error;
  UserData? get currentUser {
    if (this is AuthStateInRegister) {
      return (this as AuthStateInRegister).localUser;
    }
    if (this is AuthStateInProfileCompletion) {
      return (this as AuthStateInProfileCompletion).localUser;
    }
    if (this is AuthStateProfileCompleted) {
      return (this as AuthStateProfileCompleted).localUser;
    }

    return null;
  }

  User? get firebaseUser {
    if (this is AuthStateInRegister) {
      return (this as AuthStateInRegister).firebaseUser;
    }
    if (this is AuthStateInProfileCompletion) {
      return (this as AuthStateInProfileCompletion).firebaseUser;
    }
    if (this is AuthStateProfileCompleted) {
      return (this as AuthStateProfileCompleted).firebaseUser;
    }
    return null;
  }

  bool get isAuthenticated => firebaseUser != null;
  bool get isProfileCompleted => this is AuthStateProfileCompleted;
  bool get isInProfileCompletion => this is AuthStateInProfileCompletion;

  bool? get emailVerified {
    if (this is AuthStateInProfileCompletion) {
      return (this as AuthStateInProfileCompletion).emailVerified;
    }
    return null;
  }
}

extension AuthProviderX on AuthProvider {
  bool get isEmail => this == AuthProvider.email;
  bool get isGoogle => this == AuthProvider.google;
  bool get isApple => this == AuthProvider.apple;
  bool get isPhone => this == AuthProvider.phone;
}
