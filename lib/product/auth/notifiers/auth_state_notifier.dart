import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/constants/constants.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/models/auth_error.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/models/auth_state.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/models/user_model.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/service/authenticator.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthStateUnknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      getCurrentUser().whenComplete(
        () => Future.delayed(
          const Duration(seconds: 1),
          FlutterNativeSplash.remove,
        ),
      );
    } else {
      FlutterNativeSplash.remove();
    }
  }
  final _authenticator = const Authenticator();

  Future<void> getCurrentUser() async {
    final authenticationState = await _authenticator.checkSignedInUser();

    if (authenticationState.isLeft) {
      state = authenticationState.left;
      return;
    }
    if (authenticationState.isRight) {
      state = state.copyWith(
        error: authenticationState.right,
        isLoading: false,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copyWith(isLoading: true);
    await _authenticator.logOut();
    state = const AuthStateUnknown();
  }

  Future<void> updateUserData(
    UserData newUserData, {
    String? email,
    String? password,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _authenticator.updateUserData(
      newUserData: newUserData,
      emailCredentials: email != null && password != null
          ? EmailAuthProvider.credential(
              email: email,
              password: password,
            ) as EmailAuthCredential
          : null,
    );
    if (result.isLeft) {
      state = result.left;
      return;
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthStateInRegister(
      isLoading: true,
      firebaseUser: null,
    );

    final result = await _authenticator.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = _authenticator.currentUser;

    if (result.isLeft && userId != null) {
      return getCurrentUser();
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (state.firebaseUser != null) {
      state = state.copyWith(isLoading: false);
    } else {
      state = const AuthStateInRegister(
        isLoading: true,
        firebaseUser: null,
      );
    }

    final result = await _authenticator.logInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userId = _authenticator.currentUser;
    if (result.isLeft && userId != null) {
      return getCurrentUser();
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AuthStateInRegister(
      isLoading: true,
      firebaseUser: null,
    );

    final result = await _authenticator.loginWithGoogle();
    final firebaseUser = _authenticator.currentUser;

    if (result.isLeft && firebaseUser != null) {
      if (result.left?.additionalUserInfo?.isNewUser ?? true) {
        await _authenticator.currentUser?.delete();
        await logOut();

        state = state.copyWith(
          isLoading: false,
          error: const AuthErrorUserNotFound(),
        );

        return;
      }
      return getCurrentUser();
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  Future<void> logInWithApple() async {
    state = const AuthStateInRegister(
      isLoading: true,
      firebaseUser: null,
    );
    final result = await _authenticator.logInWithApple();
    final userId = _authenticator.currentUser;

    if (result.isLeft && userId != null) {
      if (result.left?.additionalUserInfo?.isNewUser ?? true) {
        await _authenticator.currentUser?.delete();
        await logOut();

        state = state.copyWith(
          isLoading: false,
          error: const AuthErrorUserNotFound(),
        );

        return;
      }
      return getCurrentUser();
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  String? verificationId;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    state = state.copyWith(isLoading: false);

    await _authenticator.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        this.verificationId = verificationId;
        state = state.copyWith(isLoading: false);
      },
      onVerificationFailed: (e) {
        state = state.copyWith(
          isLoading: false,
          error: AuthError.from(e),
        );
      },
    );
  }

  Future<void> loginWithPhoneNumber({
    required String smsCode,
  }) async {
    if (verificationId == null) return;
    state = state.copyWith(isLoading: true);

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    final result = await _authenticator.loginWithPhoneNumber(
      credential: credential,
    );

    final firebaseUser = _authenticator.currentUser;

    if (result.isLeft && firebaseUser != null) {
      verificationId = null;
      return getCurrentUser();
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  Future<void> linkSocialProvider(AuthProvider provider) async {
    state = state.copyWith(isLoading: true);

    final result = provider.isGoogle
        ? await _authenticator.linkGoogleProvider()
        : await _authenticator.linkAppleProvider();
    final firebaseUser = _authenticator.currentUser;

    if (result.isLeft && firebaseUser != null) {
      state = AuthStateProfileCompleted(
        localUser: state.currentUser,
        firebaseUser: firebaseUser,
      );
      return;
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  Future<void> unlinkSocialProvider(AuthProvider provider) async {
    state = state.copyWith(isLoading: true);

    final result = await _authenticator.unlinkSocialProvider(
      provider.isGoogle ? AuthConstants.googleCom : AuthConstants.appleCom,
    );
    final firebaseUser = _authenticator.currentUser;

    if (result.isLeft && firebaseUser != null) {
      state = AuthStateProfileCompleted(
        localUser: state.currentUser,
        firebaseUser: firebaseUser,
      );
      return;
    }
    if (result.isRight) {
      state = state.copyWith(
        isLoading: false,
        error: result.right,
      );
    }
  }

  bool googleProviderLinked() {
    final providers = state.firebaseUser?.providerData;
    if (providers == null) return false;
    return providers.any(
      (provider) => provider.providerId == AuthConstants.googleCom,
    );
  }

  bool appleProviderLinked() {
    final providers = state.firebaseUser?.providerData;
    if (providers == null) return false;
    return providers.any(
      (provider) => provider.providerId == AuthConstants.appleCom,
    );
  }
}
