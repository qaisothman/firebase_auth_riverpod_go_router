import 'package:firebase_auth_riverpod_go_router/product/components/custom_card.dart';
import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.leadingSize,
    this.leadingToTitle,
    this.padding,
    this.enableTrailingIcon = true,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final double? leadingSize;
  final double? leadingToTitle;
  final EdgeInsetsGeometry? padding;
  final bool enableTrailingIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const defaultPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    return CustomCard(
      child: PlatformWidget(
        cupertino: (_, __) => CupertinoListTile(
          padding: padding ?? defaultPadding,
          title: DefaultTextStyle(
            style: context.textTheme.bodyLarge ?? const TextStyle(),
            child: title ?? const SizedBox.shrink(),
          ),
          subtitle: subtitle,
          leading: leading,
          trailing: trailing ??
              (enableTrailingIcon
                  ? Icon(
                      CupertinoIcons.chevron_right,
                      color: context.theme.colorScheme.onBackground,
                    )
                  : null),
          onTap: onTap,
          leadingSize: leadingSize ?? 40,
          leadingToTitle: leadingToTitle ?? 16,
        ),
        material: (_, __) => ListTile(
          contentPadding: padding ?? defaultPadding,
          title: DefaultTextStyle(
            style: context.textTheme.bodyLarge ?? const TextStyle(),
            child: title ?? const SizedBox.shrink(),
          ),
          subtitle: subtitle,
          leading: leading,
          trailing: trailing ??
              (enableTrailingIcon
                  ? Icon(
                      FluentIcons.chevron_right_24_regular,
                      color: context.theme.colorScheme.onBackground,
                    )
                  : null),
          onTap: onTap,
          minLeadingWidth: leadingSize ?? 40,
          horizontalTitleGap: leadingToTitle ?? 16,
          dense: true,
        ),
      ),
    );
  }
}
