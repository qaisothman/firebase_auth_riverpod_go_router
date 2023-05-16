import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_text_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:open_mail_app/open_mail_app.dart';

class VerifyUserEmailPage extends ConsumerWidget {
  const VerifyUserEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return CustomScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.verifyYourEmail),
            actions: [
              GenericTextButton(
                padding: const EdgeInsets.only(right: 16),
                onPressed: () async =>
                    ref.read(authStateProvider.notifier).logOut(),
                child: Text(l10n.logout),
              ),
            ],
          ),
          const SliverGap(16),
          SliverFluidBox(
            child: Text(l10n.verifyYourEmailMessage),
          ),
          const SliverGap(48),
          SliverFluidBox(
            child: GenericElevatedButton(
              child: Text(l10n.openEmailApp),
              onPressed: () async {
                final result = await OpenMailApp.openMailApp();
                if (!result.didOpen && result.canOpen && context.mounted) {
                  await showPlatformDialog<void>(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
