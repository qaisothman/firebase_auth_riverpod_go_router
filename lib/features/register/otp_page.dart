// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth_riverpod_go_router/core/extensions/lists/add_item_in_between.dart';
import 'package:firebase_auth_riverpod_go_router/core/utils/count_down_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/auth/providers/auth_state_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_text_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends HookConsumerWidget {
  const OtpPage({
    required this.phoneNumber,
    this.onCompleted,
    this.isInProfileCompletion = false,
    super.key,
  });

  final String phoneNumber;
  final void Function(String)? onCompleted;
  final bool isInProfileCompletion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restartKey = useState(UniqueKey());
    final countDown = useMemoized(
      () => CountDown(from: 120),
      [restartKey.value],
    );
    final notifier = useListenable(countDown);
    final pinputController = useTextEditingController();

    return CustomScaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
          SliverFluidBox(
            child: Text(
              context.l10n.enterVerificationCode,
            ),
          ),
          SliverFluidBox(
            child: Pinput(
              length: 6,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              controller: pinputController,
              defaultPinTheme: PinTheme(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black54.withOpacity(0.05),
                ),
                textStyle: context.theme.textTheme.titleLarge,
                constraints: BoxConstraints(
                  minHeight: 72,
                  minWidth: 48,
                ),
              ),
              disabledPinTheme: PinTheme(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: context.theme.textTheme.displaySmall,
              ),
              onCompleted: onCompleted ??
                  (code) async => ref
                      .read(
                        authStateProvider.notifier,
                      )
                      .loginWithPhoneNumber(
                        smsCode: code,
                      ),
              autofocus: true,
            ),
          ),
          SliverFluidBox(
            child: ValueListenableBuilder<int>(
              valueListenable: notifier,
              builder: (context, value, _) {
                final minutes = value ~/ 60;
                final seconds = value - minutes * 60;

                return Text(
                  seconds >= 10 ? '0$minutes:$seconds' : '0$minutes:0$seconds',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: (minutes == 0 && seconds < 30)
                        ? context.theme.colorScheme.error
                        : null,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          SliverAnimatedOpacity(
            opacity: notifier.value == 0 ? 1 : 0.5,
            duration: Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            sliver: SliverFluidBox(
              child: GenericTextButton(
                disabled: notifier.value != 0,
                child: Text(
                  context.l10n.resendCode,
                ),
                onPressed: () {
                  restartKey.value = UniqueKey();
                  ref
                      .read(authStateProvider.notifier)
                      .verifyPhoneNumber(phoneNumber);
                },
              ),
            ),
          ),
        ].addItemInBetween(
          SliverGap(12),
        ),
      ),
    );
  }
}
