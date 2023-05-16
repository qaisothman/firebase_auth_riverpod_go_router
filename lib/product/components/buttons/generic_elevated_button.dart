import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:layout/layout.dart';

class GenericElevatedButton extends StatelessWidget {
  const GenericElevatedButton({
    this.onPressed,
    this.child,
    this.icon,
    this.padding,
    this.alignment,
    this.childrenAlignment,
    this.color,
    this.disabledColor,
    this.borderRadius,
    super.key,
  });

  final void Function()? onPressed;
  final Widget? child;
  final Widget? icon;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;
  final MainAxisAlignment? childrenAlignment;
  final Color? color;
  final Color? disabledColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    const defaultPadding = EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    );
    const defaultBorderRadius = BorderRadius.all(Radius.circular(12));
    return PlatformElevatedButton(
      cupertino: (context, _) => CupertinoElevatedButtonData(
        onPressed: onPressed,
        padding: padding ?? defaultPadding,
        alignment: alignment ?? Alignment.center,
        color: color,
        disabledColor: disabledColor,
        minSize: context.layout.value(
          xs: 40,
          sm: 40,
          md: 52,
        ),
        borderRadius: borderRadius ?? defaultBorderRadius,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: childrenAlignment ?? MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 8),
            if (child != null) child!,
          ],
        ),
      ),
      material: (context, _) => MaterialElevatedButtonData(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? defaultPadding,
          elevation: 0,
          alignment: alignment ?? Alignment.center,
          backgroundColor: color,
          disabledBackgroundColor: disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? defaultBorderRadius,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: childrenAlignment ?? MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 8),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
