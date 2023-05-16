import 'package:firebase_auth_riverpod_go_router/core/extensions/context/bottom_padding.dart';
import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/core/init/validators.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_text_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

class LoginWithEmailPage extends HookConsumerWidget {
  const LoginWithEmailPage({
    required this.email,
    super.key,
  });
  final String email;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController(text: email);
    final passwordController = useTextEditingController();

    return CustomScaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(),
            SliverFluidBox(
              child: TextFormField(
                controller: emailController,
                decoration: DefaultInputDecoration(context: context).copyWith(
                  hintText: context.l10n.enterEmail,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? email) => Validators.isValidEmail(email)
                    ? null
                    : context.l10n.invalidEmail,
              ),
            ),
            SliverFluidBox(
              child: TextFormField(
                controller: passwordController,
                decoration: DefaultInputDecoration(context: context)
                    .copyWith(hintText: context.l10n.enterPassword),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            SliverFluidBox(
              child: GenericElevatedButton(
                child: Text(context.l10n.login),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    ref
                        .read(authStateProvider.notifier)
                        .logInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GenericTextButton(
                    child: Text(context.l10n.forgetPassword),
                    onPressed: () {},
                  ),
                  Gap(context.viewPadding.bottom),
                ],
              ),
            ),
          ].addItemInBetween(
            const SliverGap(12),
          ),
        ),
      ),
    );
  }
}
