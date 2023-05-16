import 'package:firebase_auth_riverpod_go_router/core/components/disabled.dart';
import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class GenericTextButton extends StatelessWidget {
  const GenericTextButton({
    this.onPressed,
    this.child,
    this.color,
    this.padding,
    this.alignment,
    this.textStyle,
    this.disabled = false,
    super.key,
  });

  final void Function()? onPressed;
  final Widget? child;
  final Color? color;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;
  final TextStyle? textStyle;
  final bool disabled;
  @override
  Widget build(BuildContext context) {
    return ColoredDisabled(
      disabled: disabled,
      child: PlatformTextButton(
        padding: padding ?? EdgeInsets.zero,
        color: color ?? Colors.transparent,
        onPressed: onPressed,
        alignment: alignment ?? Alignment.center,
        child: DefaultTextStyle(
          style: textStyle ??
              TextStyle(
                color: context.theme.colorScheme.primary,
              ),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
