import 'package:firebase_auth_riverpod_go_router/product/components/dialogs/generic_dialog.dart';
import 'package:firebase_auth_riverpod_go_router/product/l10n/l10n.dart';
import 'package:flutter/material.dart' show BuildContext;

/// [showUnlinkProviderDialog] shows an error dialog based on the [AuthError]
Future<bool?> showUnlinkProviderDialog({
  required BuildContext context,
}) {
  return showGenericDialog<bool>(
    context: context,
    title: context.l10n.unlinkProviderDialogTitle,
    content: context.l10n.unlinkProviderDialogMessage,
    optionsBuilder: () => {
      context.l10n.close: false,
      context.l10n.unlink: true,
    },
    optionSettings: {
      context.l10n.unlink: {
        'isDestructive': true,
      },
    },
  );
}
