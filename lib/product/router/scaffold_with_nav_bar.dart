import 'package:firebase_auth_riverpod_go_router/product/components/loading/is_loading_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/loading_screen.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(
          key: key ?? const ValueKey<String>('ScaffoldWithNavBar'),
        );

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ScaffoldWithNavBarState();
}

class ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar> {
  late final List<BottomNavigationBarItem> _items = [];
  late final StatefulNavigationShell _navigationShell;

  @override
  void initState() {
    super.initState();
    _navigationShell = widget.navigationShell;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_items.isEmpty) {
      _items.addAll(
        [
          const BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_24_regular),
            activeIcon: Icon(FluentIcons.home_24_filled),
            label: 'Main Page',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FluentIcons.dock_20_regular),
            activeIcon: Icon(FluentIcons.dock_20_filled),
            label: 'Page 1',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FluentIcons.wallet_24_regular),
            activeIcon: Icon(FluentIcons.wallet_24_filled),
            label: 'Page 2',
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(
      isLoadingProvider,
      (_, isLoading) {
        if (isLoading) {
          LoadingScreen.instance().show(
            context: context,
          );
        } else {
          LoadingScreen.instance().hide();
        }
      },
    );

    return CustomScaffold(
      body: _navigationShell,
      bottomNavigationBar: _CustomNavBar(
        currentIndex: _navigationShell.currentIndex,
        items: _items,
        itemChanged: (index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    _navigationShell.goBranch(
      index,
      initialLocation: index == _navigationShell.currentIndex,
    );
  }
}

class _CustomNavBar extends PlatformNavBar {
  _CustomNavBar({
    required super.currentIndex,
    required super.items,
    required super.itemChanged,
  }) : super(
          material: (context, _) => MaterialNavBarData(
            backgroundColor:
                context.theme.scaffoldBackgroundColor.withOpacity(0.75),
            selectedItemColor: context.theme.colorScheme.primary,
            unselectedItemColor:
                context.textTheme.titleLarge?.color?.withOpacity(0.5),
            elevation: 0,
            iconSize: 24,
          ),
          cupertino: (context, _) => CupertinoTabBarData(
            iconSize: 24,
            backgroundColor:
                context.theme.scaffoldBackgroundColor.withOpacity(0.75),
          ),
        );
}
