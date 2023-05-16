import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:math' show Random;

import 'package:crypto/crypto.dart' show sha256;
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Authenticator {
  const Authenticator();

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;
  bool get isAlreadyLoggedIn => currentUser != null;
  User? get currentUser => _firebaseAuth.currentUser;
  String get displayName => currentUser?.displayName ?? '';
  String? get email => currentUser?.email;

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<Either<AuthState, AuthError>> checkSignedInUser() async {
    try {
      await _firebaseAuth.currentUser?.reload();
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        // if (user.email != null && !user.emailVerified) {
        //   await user.sendEmailVerification();
        //   final localUser = parseLocalUser(user);
        //   return Left(
        //     AuthStateInProfileCompletion(
        //       firebaseUser: user,
        //       localUser: localUser,
        //       emailVerified: false,
        //     ),
        //   );
        // }

        final userData = await _getUserData(user.uid, user);
        if (userData != null) {
          final localUser = UserData.fromJson(userData);
          final missingData = localUser.firstName == null ||
              localUser.lastName == null ||
              localUser.email == null ||
              localUser.phoneNumber == null;

          return Left(
            missingData
                ? AuthStateInProfileCompletion(
                    firebaseUser: user,
                    localUser: localUser,
                  )
                : AuthStateProfileCompleted(
                    firebaseUser: user,
                    localUser: localUser,
                  ),
          );
        }

        final newUser = parseLocalUser(user);
        return Left(
          AuthStateProfileCompleted(
            localUser: newUser,
            firebaseUser: user,
          ),
        );
      }
      return const Left(AuthStateUnknown());
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  Future<Either<AuthState, AuthError>> updateUserData({
    required UserData? newUserData,
    EmailAuthCredential? emailCredentials,
  }) async {
    try {
      await _firebaseAuth.currentUser?.reload();
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(
          '${newUserData?.firstName} ${newUserData?.lastName}',
        );
        await firebaseUser.updatePhotoURL(newUserData?.photoUrl);
        if (emailCredentials != null) {
          await firebaseUser.updateEmail(emailCredentials.email);
          await firebaseUser.linkWithCredential(emailCredentials);


          // if (!firebaseUser.emailVerified) {
          //   await firebaseUser.sendEmailVerification();
          //   return Left(
          //     AuthStateInProfileCompletion(
          //       firebaseUser: firebaseUser,
          //       emailVerified: false,
          //     ),
          //   );
          // }
        }

        await firebaseUser.reload();

        final newLocalUser = parseLocalUser(firebaseUser);
        return Left(
          AuthStateProfileCompleted(
            localUser: newLocalUser,
            firebaseUser: firebaseUser,
          ),
        );
      }

      return const Right(AuthErrorUnknown());
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  Future<Map<String, dynamic>?> _getUserData(String uid, [User? user]) async {
    try {
      if (kDebugMode) {
        return {
          'uid': user?.uid,
          'firstName': user?.displayName?.split(' ').first,
          'lastName': user?.displayName?.split(' ').last,
          'email': user?.email,
          'phoneNumber': user?.phoneNumber,
          'photoUrl': user?.photoURL,
        };
      }

      // return await FirebaseCollections.users.reference.doc(uid).get().then(
      //       (doc) => doc.exists ? doc.data() as Map<String, dynamic> : null,
      //     );
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Either<AuthResult, AuthError>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const Left(AuthResult.authenticated);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  Future<Either<AuthResult, AuthError>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Left(AuthResult.authenticated);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  Future<Either<UserCredential?, AuthError>> loginWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        AuthConstants.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return const Left(null);
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredentials,
      );

      return Left(userCredential);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  Future<Either<bool, AuthError>> linkGoogleProvider() async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        AuthConstants.emailScope,
      ],
    );
    try {
      final signInAccount = await googleSignIn.signIn();
      if (signInAccount == null) {
        return const Right(AuthErrorUnknown());
      }

      final googleAuth = await signInAccount.authentication;
      final oauthCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _firebaseAuth.currentUser?.linkWithCredential(oauthCredentials);
      await _firebaseAuth.currentUser?.reload();

      return const Left(true);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  /// signs in the user using [SignInWithApple]
  Future<Either<UserCredential?, AuthError>> logInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    try {
      // get the [AppleIDCredential] from [SignInWithApple]
      final appleAuth = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // create an [OAuthCredential] from the [AppleIDCredential]
      final oauthCredential = OAuthProvider(AuthConstants.appleCom).credential(
        idToken: appleAuth.identityToken,
        rawNonce: rawNonce,
      );

      // sign in with the [OAuthCredential]
      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      return Left(userCredential);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  Future<Either<bool, AuthError>> linkAppleProvider() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    try {
      // get the [AppleIDCredential] from [SignInWithApple]
      final appleAuth = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // create an [OAuthCredential] from the [AppleIDCredential]
      final oauthCredential = OAuthProvider(AuthConstants.appleCom).credential(
        idToken: appleAuth.identityToken,
        rawNonce: rawNonce,
      );

      await _firebaseAuth.currentUser?.linkWithCredential(oauthCredential);
      await _firebaseAuth.currentUser?.reload();

      return const Left(true);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  String _generateNonce() {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';

    final random = Random.secure();
    return List.generate(
      32,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String) onCodeSent,
    required void Function(FirebaseAuthException) onVerificationFailed,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      verificationFailed: onVerificationFailed,
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: onCodeSent,
      verificationCompleted: (_) {},
    );
  }

  Future<Either<AuthResult, AuthError>> loginWithPhoneNumber({
    required PhoneAuthCredential credential,
  }) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      return const Left(AuthResult.authenticated);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    }
  }

  Future<Either<bool, AuthError>> unlinkSocialProvider(
    String providerId,
  ) async {
    try {
      await _firebaseAuth.currentUser?.unlink(providerId);
      await _firebaseAuth.currentUser?.reload();
      return const Left(true);
    } on FirebaseAuthException catch (e) {
      return Right(AuthError.from(e));
    } catch (e) {
      return const Right(AuthErrorUnknown());
    }
  }

  UserData parseLocalUser(User user) {
    return UserData(
      uid: user.uid,
      firstName: user.displayName?.split(' ').first,
      lastName: user.displayName?.split(' ').last,
      email: user.email,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
    );
  }
}
