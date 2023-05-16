import 'dart:math' show max;

import 'package:flutter/material.dart'
    show BuildContext, EdgeInsets, MediaQuery;

extension PaddingX on BuildContext {
  double get floatingBottomPadding {
    final mediaQuery = MediaQuery.of(this);
    return max(
      mediaQuery.viewInsets.bottom + 16.0,
      mediaQuery.viewPadding.bottom,
    );
  }

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
}
