import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class GenericIconButton extends StatelessWidget {
  const GenericIconButton({
    required this.onPressed,
    required this.icon,
    this.color,
    this.padding,
    super.key,
  });
  final void Function()? onPressed;
  final Widget? icon;
  final Color? color;
  final EdgeInsets? padding;
  

  @override
  Widget build(BuildContext context) {
    return PlatformElevatedButton(
      padding: padding ?? EdgeInsets.zero,
      color: color ?? context.theme.colorScheme.primary,
      cupertino: (_, __) => CupertinoElevatedButtonData(
        borderRadius: BorderRadius.circular(50),
      ),
      material: (_, __) => MaterialElevatedButtonData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
