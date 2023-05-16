import 'package:firebase_auth_riverpod_go_router/product/auth/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final goRouterNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});

class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;

  bool isAuthenticated = false;
  bool isInProfileCompletion = false;
  bool isProfileCompleted = false;
  bool? emailVerified;
  @override
  Future<void> build() async {
    isAuthenticated = await ref.watch(isAuthenticatedProvider);
    isInProfileCompletion = await ref.watch(isInProfileCompletionProvider);
    isProfileCompleted = await ref.watch(isProfileCompletedProvider);
    emailVerified = await ref.watch(emailVerifiedProvider);

    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}
