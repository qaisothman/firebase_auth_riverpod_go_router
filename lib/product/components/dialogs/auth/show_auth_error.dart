import 'package:firebase_auth_riverpod_go_router/product/auth/models/models.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/dialogs/generic_dialog.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart' show BuildContext;



/// [showAuthError] shows an error dialog based on the [AuthError]
Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  final errorData = parseAuthErrorTextsFromCode(
    code: authError.code,
    l10n: context.l10n,
  );
  return showGenericDialog<void>(
    context: context,
    title: errorData.key,
    content: errorData.value,
    optionsBuilder: () => {
      context.l10n.close: true,
    },
  );
}
