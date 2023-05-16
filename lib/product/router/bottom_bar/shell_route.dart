// https://gist.github.com/tolo/f7e6c30cad3ac76085d75255ba509f10

import 'package:firebase_auth_riverpod_go_router/product/router/bottom_bar/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';

class BottomTabBarShellRoute extends ShellRoute {
  BottomTabBarShellRoute({
    super.navigatorKey,
    super.routes,
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
          builder: (context, state, currentNav) {
            return Layout(
              child: Stack(
                children: [
                  Offstage(child: currentNav),
                  ScaffoldWithNavBar(
                    key: scaffoldKey,
                    currentNavigator:
                        (currentNav as HeroControllerScope).child as Navigator,
                    currentRouterState: state,
                    routes: routes,
                  ),
                ],
              ),
            );
          },
        );
}
