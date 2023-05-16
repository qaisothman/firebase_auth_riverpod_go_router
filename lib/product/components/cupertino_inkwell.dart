import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// An [InkWell] equivalent for Cupertino. Simply colors the background of the container.
class CupertinoInkWell extends StatefulWidget {
  const CupertinoInkWell({
    required this.child,
    required this.onTap,
    this.onLongPress,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  bool get enabled => onTap != null;

  @override
  State<CupertinoInkWell> createState() => _CupertinoInkWellState();
}

class _CupertinoInkWellState extends State<CupertinoInkWell> {
  bool _buttonHeldDown = false;

  late final VoidCallback? _onLongPress;
  late final VoidCallback? _onTap;

  @override
  void initState() {
    super.initState();
    _onLongPress = widget.onLongPress;
    _onTap = widget.onTap;
  }

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      setState(() => _buttonHeldDown = true);
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      setState(() => _buttonHeldDown = false);
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      setState(() => _buttonHeldDown = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled;
    final child = widget.child;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: _onTap,
      onLongPress: _onLongPress,
      child: Semantics(
        button: true,
        child: _buttonHeldDown
            ? ColoredBox(
                color: CupertinoColors.systemFill.resolveFrom(context),
                child: child,
              )
            : child,
      ),
    );
  }
}
