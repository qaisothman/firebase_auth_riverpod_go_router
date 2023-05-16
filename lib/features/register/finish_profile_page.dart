import 'package:firebase_auth_riverpod_go_router/core/extensions/context/bottom_padding.dart';
import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/core/init/validators.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/models/auth_state.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/user_provider.dart';
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

class FinishProfilePage extends HookConsumerWidget {
  const FinishProfilePage({super.key});
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

    final user = ref.watch(currentUserProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController(text: user?.firstName);
    final surnameController = useTextEditingController(text: user?.lastName);
    final emailController = useTextEditingController(text: user?.email);
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    ref.listen(
      authStateProvider,
      (previous, next) async {
        if (previous is AuthStateInProfileCompletion &&
            next is AuthStateUnknown) {
          context.replace(Routes.landing.key);
        }
      },
    );

    return CustomScaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TextButton(
                    onPressed: ref.read(authStateProvider.notifier).logOut,
                    child: Text(context.l10n.logout),
                  ),
                )
              ],
              title: Text(context.l10n.finishProfile),
            ),
            _NameField(
              title: context.l10n.yourName,
              hint: context.l10n.enterName,
              controller: nameController,
            ),
            _NameField(
              title: context.l10n.yourSurname,
              hint: context.l10n.enterSurname,
              controller: surnameController,
            ),
            if (user?.email?.isEmpty ?? true) ...[
              SliverFluidBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.yourEmail),
                    const Gap(8),
                    TextFormField(
                      decoration:
                          DefaultInputDecoration(context: context).copyWith(
                        hintText: context.l10n.enterEmail,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      controller: emailController,
                      validator: (String? email) =>
                          Validators.isValidEmail(email)
                              ? null
                              : context.l10n.invalidEmail,
                    ),
                    const Gap(16),
                    TextFormField(
                      decoration:
                          DefaultInputDecoration(context: context).copyWith(
                        hintText: context.l10n.enterPassword,
                        hintMaxLines: 10,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      controller: passwordController,
                      validator: (password) {
                        if (Validators.isValidPassword(password) ||
                            (password?.isEmpty ?? true)) {
                          return context.l10n.invalidPasswordMessage;
                        }
                        if (password != confirmPasswordController.text) {
                          return context.l10n.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      decoration:
                          DefaultInputDecoration(context: context).copyWith(
                        hintText: context.l10n.confirmPassword,
                        hintMaxLines: 10,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: confirmPasswordController,
                      validator: (repeatedPassword) {
                        if (Validators.isValidPassword(repeatedPassword) ||
                            (repeatedPassword?.isEmpty ?? true)) {
                          return context.l10n.invalidPasswordMessage;
                        }
                        if (repeatedPassword != passwordController.text) {
                          return context.l10n.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
            SliverFillRemaining(
              hasScrollBody: false,
              child: FluidMargin(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GenericElevatedButton(
                      child: Text(context.l10n.next),
                      onPressed: () async {
                        final notifier = ref.read(
                          authStateProvider.notifier,
                        );
                        if ((formKey.currentState?.validate() ?? false) &&
                            user != null) {
                          formKey.currentState?.save();

                          final newUserData = user.copyWith(
                            firstName: nameController.text,
                            lastName: surnameController.text,
                            email: emailController.text,
                            photoUrl: user.photoUrl,
                          );

                          await notifier.updateUserData(
                            newUserData,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                    Gap(context.floatingBottomPadding),
                  ],
                ),
              ),
            ),
          ].addItemInBetween(
            const SliverGap(16),
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({
    this.controller,
    this.title,
    this.hint,
  });
  final TextEditingController? controller;
  final String? title;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return SliverFluidBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!),
          const Gap(8),
          TextFormField(
            controller: controller,
            decoration: DefaultInputDecoration(context: context)
                .copyWith(hintText: hint),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            validator: (name) =>
                name?.isEmpty ?? false ? context.l10n.requiredField : null,
          ),
        ],
      ),
    );
  }
}
