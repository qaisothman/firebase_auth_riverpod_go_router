import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
UserData? currentUser(CurrentUserRef ref) =>
    ref.watch(authStateProvider).currentUser;

@riverpod
User? currentFirebaseUser(CurrentFirebaseUserRef ref) =>
    ref.watch(authStateProvider).firebaseUser;


@riverpod
bool isProfileCompleted(IsProfileCompletedRef ref) =>
    ref.watch(authStateProvider).isProfileCompleted;

@riverpod
bool isInProfileCompletion(IsProfileCompletedRef ref) =>
    ref.watch(authStateProvider).isInProfileCompletion;

@riverpod
bool? emailVerified(EmailVerifiedRef ref) =>
    ref.watch(authStateProvider).emailVerified;

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) =>
    ref.watch(authStateProvider).isAuthenticated;
