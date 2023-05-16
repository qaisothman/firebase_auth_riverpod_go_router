import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// [DialogOptionBuilder] handles options in the generic dialog
/// it returns a map of [String] and [T] where the [String] is the title
/// of the option and the [T] is the value that will be returned when
/// the option is selected
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

/// [showGenericDialog] shows a generic dialog with a title, a content
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionsBuilder,
  Map<String, Map<String, bool>> optionSettings = const {},
  bool isDismissible = false,
}) {
  final options = optionsBuilder();

  return showPlatformDialog<T>(
    context: context,
    barrierDismissible: isDismissible,
    builder: (context) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        child: PlatformAlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actions: [
            ...options.keys.map(
              (optionTitle) {
                final value = options[optionTitle];
                final isDestructive =
                    optionSettings[optionTitle]?['isDestructive'] ?? false;
                final isDefault =
                    optionSettings[optionTitle]?['isDefault'] ?? false;
                return PlatformDialogAction(
                  child: Text(optionTitle),
                  cupertino: (_, __) => CupertinoDialogActionData(
                    isDestructiveAction: isDestructive,
                    isDefaultAction: isDefault,
                  ),
                  onPressed: () => value != null
                      ? Navigator.of(context).pop(value)
                      : Navigator.pop(context),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
