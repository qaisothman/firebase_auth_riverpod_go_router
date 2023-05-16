import 'package:firebase_auth_riverpod_go_router/product/components/cupertino_inkwell.dart';
import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    this.color,
    this.elevation,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.clip = true,
    this.onTap,
    this.onLongPress,
    this.shadowColor,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  const CustomCard.smallRadius({
    required this.child,
    this.color,
    this.elevation,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onTap,
    this.onLongPress,
    this.clip = true,
    this.padding = EdgeInsets.zero,
    this.shadowColor,
    super.key,
  });

  final Widget child;
  final Color? color;
  final double? elevation;
  final BorderRadius borderRadius;
  final bool clip;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? shadowColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.theme.brightness.isDark;
    final elevation = this.elevation ?? (isDarkMode ? 0 : 8);
    final shadow = shadowColor ?? Colors.black.withOpacity(0.1);
    final color = this.color ?? context.theme.cardColor;

    final Widget child = Padding(padding: padding!, child: this.child);
    return Material(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      elevation: elevation,
      shadowColor: shadow,
      color: color,
      clipBehavior: clip == true ? Clip.antiAlias : Clip.none,
      child: PlatformWidget(
        material: (_, __) => InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        ),
        cupertino: (_, __) => CupertinoInkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}
