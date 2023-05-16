import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/core/init/validators.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/auth.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_elevated_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/custom_scaffold.dart';
import 'package:firebase_auth_riverpod_go_router/product/constants/default_input_decoration.dart';
import 'package:firebase_auth_riverpod_go_router/product/l10n/l10n.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

class VerifyPhonePage extends HookConsumerWidget {
  const VerifyPhonePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final phoneController = useTextEditingController();

    return CustomScaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(),
            SliverFluidBox(
              child: TextFormField(
                controller: phoneController,
                decoration: DefaultInputDecoration(context: context).copyWith(
                  hintText: context.l10n.enterPhone,
                ),
                keyboardType: TextInputType.phone,
                validator: (String? phone) => Validators.isValidPhone(phone)
                    ? null
                    : context.l10n.invalidPhoneNumber,
              ),
            ),
            SliverFluidBox(
              child: GenericElevatedButton(
                child: Text(context.l10n.verify),
                onPressed: () async {
                  final notifier = ref.read(
                    authStateProvider.notifier,
                  );
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    await notifier.verifyPhoneNumber(
                      phoneController.text,
                    );
                    if (context.mounted) {
                      await context.pushNamed(
                        Routes.otpPage.value,
                        extra: {
                          'phoneNumber': phoneController.text,
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
          ].addItemInBetween(
            const SliverGap(12),
          ),
        ),
      ),
    );
  }
}
