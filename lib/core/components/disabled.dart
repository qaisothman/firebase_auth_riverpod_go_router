import 'package:flutter/widgets.dart';

class Disabled extends StatelessWidget {
  const Disabled({
    required this.child,
    this.disabled = true,
    super.key,
  });
  final bool disabled;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (!disabled) return child;
    return IgnorePointer(
      child: Opacity(
        opacity: 0.25,
        child: ColorFiltered(
          colorFilter: _saturationColorMatrix,
          child: child,
        ),
      ),
    );
  }
}

const _saturationColorMatrix = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);

class ColoredDisabled extends StatelessWidget {
  const ColoredDisabled({
    required this.child,
    this.disabled = true,
    super.key,
  });
  final bool disabled;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (!disabled) return child;
    return IgnorePointer(
      child: Opacity(
        opacity: 0.75,
        child: child,
      ),
    );
  }
}
