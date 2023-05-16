import 'package:firebase_auth_riverpod_go_router/core/init/validators.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';

class RegisterCredentialsField extends StatelessWidget {
  const RegisterCredentialsField({
    this.credentialController,
    this.onSaved,
    super.key,
  });
  final TextEditingController? credentialController;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: credentialController,
      keyboardType: TextInputType.emailAddress,
      decoration: DefaultInputDecoration(context: context).copyWith(
        hintText: context.l10n.enterEmailOrPhone,
      ),
      validator: (String? text) {
        final isValidText =
            Validators.isValidEmail(text) || Validators.isValidPhone(text);
        if ((text?.isNotEmpty ?? false) && isValidText) return null;
        return context.l10n.invalidEmailOrPhone;
      },
      onSaved: onSaved,
    );
  }
}
