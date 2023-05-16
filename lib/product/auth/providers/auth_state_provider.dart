import 'package:firebase_auth_riverpod_go_router/product/auth/auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/notifiers/auth_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifierProvider;

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
