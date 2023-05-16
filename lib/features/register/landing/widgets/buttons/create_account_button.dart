import 'package:firebase_auth_riverpod_go_router/product/components/buttons/generic_text_button.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericTextButton(
      onPressed: () => context.goNamed(Routes.verifyPhonePage.value),
      child: Text(context.l10n.createAccount),
    );
  }
}
