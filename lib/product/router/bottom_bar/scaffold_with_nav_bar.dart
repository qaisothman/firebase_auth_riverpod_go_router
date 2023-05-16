import 'package:firebase_auth_riverpod_go_router/product/components/custom_scaffold.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/is_loading_provider.dart';
import 'package:firebase_auth_riverpod_go_router/product/components/loading/loading_screen.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/bottom_bar/bottom_tab_bar.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<NavigatorState> _mainPageNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'mainPageKey');
final GlobalKey<NavigatorState> _page1NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'page1Key');
final GlobalKey<NavigatorState> _page2NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'page2Key');

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithNavBar({
    required this.currentNavigator,
    required this.currentRouterState,
    required this.routes,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final Navigator currentNavigator;

  List<Page<dynamic>> get pagesForCurrentRoute => currentNavigator.pages;

  final GoRouterState currentRouterState;

  final List<RouteBase> routes;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar> {
  late final List<NavBarTabNavigator> _tabs = [];

  int _locationToTabIndex(String location) {
    final index = _tabs.indexWhere(
      (NavBarTabNavigator t) => location.startsWith(t.rootRoutePath),
    );
    return index < 0 ? 0 : index;
  }

  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_tabs.isEmpty) {
      _tabs.addAll(
        [
          ScaffoldWithNavBarTabItem(
            rootRoutePath: Routes.mainPage.key,
            navigatorKey: _mainPageNavigatorKey,
            icon: const Icon(FluentIcons.home_24_regular),
            activeIcon: const Icon(FluentIcons.home_24_filled),
            label: 'Main Page',
          ),
          ScaffoldWithNavBarTabItem(
            rootRoutePath: Routes.page1.key,
            navigatorKey: _page1NavigatorKey,
            icon: const Icon(FluentIcons.dock_20_regular),
            activeIcon: const Icon(FluentIcons.dock_20_filled),
            label: 'Page 1',
          ),
          ScaffoldWithNavBarTabItem(
            rootRoutePath: Routes.page2.key,
            navigatorKey: _page2NavigatorKey,
            icon: const Icon(FluentIcons.wallet_24_regular),
            activeIcon: const Icon(FluentIcons.wallet_24_filled),
            label: 'Page 2',
          ),
        ].map(NavBarTabNavigator.new).toList(),
      );
    }
    _updateForCurrentTab();
  }

  void _updateForCurrentTab() {
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);
    _tabs[_currentIndex]
      ..pages = widget.pagesForCurrentRoute
      ..lastLocation = location;
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
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs
            .map(
              (NavBarTabNavigator tab) => tab.buildNavigator(context),
            )
            .toList(),
      ),
      bottomNavigationBar: CustomNavBar(
        tabs: _tabs,
        currentIndex: _currentIndex,
      ),
    );
  }
}
