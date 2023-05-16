import 'dart:ui' as ui;

import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    required this.tabs,
    required this.currentIndex,
    super.key,
  });
  final int currentIndex;
  final List<NavBarTabNavigator> tabs;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
        PlatformNavBar(
          items: tabs
              .map((NavBarTabNavigator e) => e.bottomNavigationTab)
              .toList(),
          currentIndex: currentIndex,
          itemChanged: (index) => _onItemTapped(index, context),
          material: (context, _) => MaterialNavBarData(
            backgroundColor: Colors.transparent,
            selectedItemColor: context.theme.colorScheme.primary,
            unselectedItemColor:
                context.textTheme.titleLarge?.color?.withOpacity(0.5),
            elevation: 0,
          ),
          cupertino: (context, _) => CupertinoTabBarData(
            iconSize: 24,
            backgroundColor: Colors.transparent,
            inactiveColor:
                context.textTheme.titleLarge?.color?.withOpacity(0.5),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 1,
            color: context.textTheme.titleLarge?.color?.withOpacity(0.05),
          ),
        )
      ],
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    final router = GoRouter.of(context);
    final isActive = router.location == tabs[index].currentLocation;

    if (!isActive) {
      final location = tabs[index].currentLocation.startsWith('/')
          ? tabs[index].currentLocation
          : '/${tabs[index].currentLocation}';
      router.go(location);
    }
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem({
    required this.rootRoutePath,
    required this.navigatorKey,
    required super.icon,
    required super.activeIcon,
    super.label,
  });

  /// The initial location/path
  final String rootRoutePath;

  /// Optional navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;
}

class NavBarTabNavigator {
  NavBarTabNavigator(this.bottomNavigationTab);
  final ScaffoldWithNavBarTabItem bottomNavigationTab;
  String? lastLocation;

  String get currentLocation =>
      lastLocation != null ? lastLocation! : rootRoutePath;

  String get rootRoutePath => bottomNavigationTab.rootRoutePath;
  Key? get navigatorKey => bottomNavigationTab.navigatorKey;
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  Widget buildNavigator(BuildContext context) {
    if (pages.isNotEmpty) {
      return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (pages.length == 1 || !route.didPop(result)) {
            return false;
          }
          GoRouter.of(context).pop();
          return true;
        },
      );
    }

    return const SizedBox.shrink();
  }
}
