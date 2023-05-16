
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateProvider);

  return authState.isLoading;
}
