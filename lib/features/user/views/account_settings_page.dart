import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/models/auth_state.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_icon_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/custom_card.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/dialogs/auth/unlink_provider_dialog.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleAccountLinked =
        ref.watch(authStateProvider.notifier).googleProviderLinked();
    final appleAccountLinked =
        ref.watch(authStateProvider.notifier).appleProviderLinked();

    return CustomScaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              context.l10n.accountSettingsPage,
              style: context.textTheme.titleLarge,
            ),
          ),
          SliverFluidBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.authenticationOptions,
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(16),
                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LinkProvidersButton(
                        provider: AuthProvider.google,
                        linkedAlready: googleAccountLinked,
                      ),
                      const Gap(12),
                      _LinkProvidersButton(
                        provider: AuthProvider.apple,
                        linkedAlready: appleAccountLinked,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ].addItemInBetween(
          const SliverGap(16),
        ),
      ),
    );
  }
}

class _LinkProvidersButton extends ConsumerWidget {
  const _LinkProvidersButton({
    required this.provider,
    required this.linkedAlready,
  });

  final bool linkedAlready;
  final AuthProvider provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        GenericIconButton(
          onPressed: () async => linkedAlready
              ? showUnlinkProviderDialog(context: context).then(
                  (result) => result ?? false
                      ? ref
                          .read(authStateProvider.notifier)
                          .unlinkSocialProvider(
                            provider,
                          )
                      : null,
                )
              : ref.read(authStateProvider.notifier).linkSocialProvider(
                    provider,
                  ),
          icon: Icon(
            provider.isGoogle
                ? const FaIcon(FontAwesomeIcons.google).icon
                : const FaIcon(FontAwesomeIcons.apple).icon,
          ),
        ),
        if (linkedAlready)
          const Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  FluentIcons.checkmark_16_regular,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
