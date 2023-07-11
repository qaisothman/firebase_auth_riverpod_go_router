// https://gist.github.com/tolo/f7e6c30cad3ac76085d75255ba509f10

import 'package:firebase_auth_riverpod_go_router/features/main_page/main_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/page1/page_1.dart';
import 'package:firebase_auth_riverpod_go_router/features/page2/page2.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _mainPageNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'mainPageKey',
);
final _page1NavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'page1Key',
);
final _page2NavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'page2Key',
);

class BottomTabBarShellRoute extends StatefulShellRoute {
  BottomTabBarShellRoute({
    super.parentNavigatorKey,
  }) : super.indexedStack(
          builder: (context, state, navigationShell) => ScaffoldWithNavBar(
            navigationShell: navigationShell,
          ),
          branches: [
            StatefulShellBranch(
              navigatorKey: _mainPageNavigatorKey,
              routes: [
                GoRoute(
                  path: Routes.mainPage.key,
                  name: Routes.mainPage.value,
                  builder: (context, state) => MainPage(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _page1NavigatorKey,
              routes: [
                GoRoute(
                  path: Routes.page1.key,
                  name: Routes.page1.value,
                  builder: (context, state) => Page1(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _page2NavigatorKey,
              routes: [
                GoRoute(
                  path: Routes.page2.key,
                  name: Routes.page2.value,
                  builder: (context, state) => Page2(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
          ],
        );
}
