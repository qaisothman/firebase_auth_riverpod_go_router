import 'package:firebase_auth_riverpod_go_router/core/extensions/context/bottom_padding.dart';
import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_icon_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/custom_list_tile.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/is_loading_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/loading_screen.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(
      isLoadingProvider,
      (_, isLoading) {
        if (isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: context.l10n.loading,
          );
        } else {
          LoadingScreen.instance().hide();
        }
      },
    );
    return CustomScaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            expandedHeight: 0,
            title: Text(
              context.l10n.userPage,
              style: context.textTheme.titleLarge,
            ),
            actions: [
              FluidMargin(
                child: GenericIconButton(
                  color: context.theme.colorScheme.surface,
                  icon: Icon(
                    FluentIcons.dismiss_24_regular,
                    color: context.theme.primaryColor,
                  ),
                  onPressed: context.pop,
                ),
              ),
            ],
          ),
          SliverFluidBox(
            child: CustomListTile(
              title: Text(context.l10n.accountSettingsPage),
              onTap: () async =>
                  context.pushNamed(Routes.accountSettingsPage.value),
            ),
          ),
          if (kDebugMode)
            SliverFluidBox(
              child: Text(
                '${ref.watch(authStateProvider).firebaseUser}\n\n ${ref.watch(authStateProvider).currentUser}',
              ),
            ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: FluidMargin(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GenericElevatedButton(
                    onPressed: ref.read(authStateProvider.notifier).logOut,
                    child: Text(
                      context.l10n.logout,
                    ),
                  ),
                  Gap(context.viewPadding.bottom)
                ],
              ),
            ),
          ),
        ].addItemInBetween(
          const SliverGap(16),
        ),
      ),
    );
  }
}
