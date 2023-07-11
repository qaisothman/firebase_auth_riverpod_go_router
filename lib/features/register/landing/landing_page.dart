import 'package:firebase_auth_riverpod_go_router/core/extensions/context/bottom_padding.dart';
import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/core/init/validators.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/landing/widgets/buttons/apple_button.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/landing/widgets/buttons/create_account_button.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/landing/widgets/buttons/google_button.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/widgets/credential_field.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/dialogs/auth/show_auth_error.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/is_loading_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/loading_screen.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

class LandingPage extends HookConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<bool>(
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
      )
      ..listen(
        authStateProvider,
        (_, state) async {
          if (state.hasError) {
            await showAuthError(
              authError: state.error!,
              context: context,
            );
          }
        },
      );

    final formKey = useMemoized(GlobalKey<FormState>.new);

    return CustomScaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(),
          SliverFluidBox(
            child: Form(
              key: formKey,
              child: RegisterCredentialsField(
                onSaved: (credential) async {
                  final notifier = ref.read(
                    authStateProvider.notifier,
                  );
                  if (Validators.isValidEmail(credential)) {
                    context.goNamed(
                      Routes.loginWithEmail.value,
                      queryParameters: {
                        'email': credential,
                      },
                    );
                  } else if (Validators.isValidPhone(credential)) {
                    await notifier.verifyPhoneNumber(credential!);
                    if (context.mounted) {
                      context.goNamed(
                        Routes.otpPage.value,
                        extra: {
                          'phoneNumber': credential,
                          'onCompleted': (String code) async =>
                              notifier.loginWithPhoneNumber(
                                smsCode: code,
                              ),
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ),
          SliverFluidBox(
            child: GenericElevatedButton(
              child: Text(context.l10n.login),
              onPressed: () => formKey.currentState?.validate() ?? false
                  ? formKey.currentState?.save()
                  : null,
            ),
          ),
          const SliverGap(32),
          const SliverFluidBox(
            child: LoginWithGoogle(),
          ),
          const SliverFluidBox(
            child: LoginWithApple(),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CreateAccountButton(),
                Gap(context.viewPadding.bottom),
              ],
            ),
          ),
        ].addItemInBetween(
          const SliverGap(12),
        ),
      ),
    );
  }
}
