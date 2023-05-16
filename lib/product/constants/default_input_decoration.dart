import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class DefaultInputDecoration extends InputDecoration {
  DefaultInputDecoration({
    required BuildContext context,
    BorderRadius? borderRadius,
  }) : super(
          focusColor:
              context.theme.brightness.isLight ? Colors.black : Colors.white,
          filled: true,
          fillColor: context.theme.brightness.isLight
              ? Colors.black12.withOpacity(0.04)
              : Colors.white12,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        );
}
