import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginWithGoogle extends ConsumerWidget {
  const LoginWithGoogle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GenericElevatedButton(
      onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
      icon: const FaIcon(
        FontAwesomeIcons.google,
      ),
      child: Text(context.l10n.loginWithGoogle),
    );
  }
}
