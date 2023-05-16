import 'package:firebase_auth_riverpod_go_router/core/extensions/context/bottom_padding.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';


class GenericFloatingButtonBody extends StatelessWidget {
  const GenericFloatingButtonBody({
    super.key,
    this.body,
    this.floatingButton,
  });
  final Widget? body;
  final Widget? floatingButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body ?? const SizedBox.shrink(),
        if (floatingButton != null)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastLinearToSlowEaseIn,
            bottom: context.floatingBottomPadding,
            right: 0,
            left: 0,
            child: FluidMargin(child: floatingButton!),
          ),
      ],
    );
  }
}
