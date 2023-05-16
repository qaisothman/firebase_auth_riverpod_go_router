import 'package:firebase_auth_riverpod_go_router/features/main_page/main_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/page1/page_1.dart';
import 'package:firebase_auth_riverpod_go_router/features/page2/page2.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/finish_profile_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/landing/landing_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/login_with_email_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/otp_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/verify_email_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/register/verify_phone_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/user/user_page.dart';
import 'package:firebase_auth_riverpod_go_router/features/user/views/account_settings_page.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/bottom_bar/shell_route.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/router_notifier/go_router_notifier.dart';
import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final goRouterProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final notifier = ref.watch(goRouterNotifierProvider.notifier);
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      refreshListenable: notifier,
      initialLocation: Routes.mainPage.key,
      debugLogDiagnostics: true,
      redirectLimit: 50,
      routes: [
        GoRoute(
          path: Routes.landing.key,
          name: Routes.landing.value,
          builder: (context, state) => LandingPage(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: Routes.loginWithEmail.key,
              name: Routes.loginWithEmail.value,
              builder: (context, state) => LoginWithEmailPage(
                key: state.pageKey,
                email: state.queryParams['email'] ?? '',
              ),
            ),
            GoRoute(
              path: Routes.verifyPhonePage.key,
              name: Routes.verifyPhonePage.value,
              builder: (context, state) => VerifyPhonePage(
                key: state.pageKey,
              ),
            ),
            GoRoute(
              path: Routes.otpPage.key,
              name: Routes.otpPage.value,
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                final onCompleted = extra['onCompleted'];

                return OtpPage(
                  key: state.pageKey,
                  phoneNumber: (extra['phoneNumber'] ?? '') as String,
                  onCompleted: onCompleted! as void Function(String),
                  isInProfileCompletion:
                      (extra['isInProfileCompletion'] ?? false) as bool,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.finishProfile.key,
          name: Routes.finishProfile.value,
          builder: (context, state) => FinishProfilePage(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: Routes.verifyEmail.key,
              name: Routes.verifyEmail.value,
              builder: (context, state) => VerifyUserEmailPage(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        BottomTabBarShellRoute(
          navigatorKey: shellNavigatorKey,
          routes: [
            GoRoute(
              path: Routes.mainPage.key,
              name: Routes.mainPage.value,
              builder: (context, state) => MainPage(
                key: state.pageKey,
              ),
            ),
            GoRoute(
              path: Routes.page1.key,
              name: Routes.page1.value,
              builder: (context, state) => StatisticsPage(
                key: state.pageKey,
              ),
            ),
            GoRoute(
              path: Routes.page2.key,
              name: Routes.page2.value,
              builder: (context, state) => CashbackPage(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        GoRoute(
          path: Routes.user.key,
          name: Routes.user.value,
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            child: UserPage(key: state.pageKey),
            transitionsBuilder: (context, animation, _, child) {
              const begin = Offset(0, 1);
              const end = Offset.zero;
              const curve = Curves.fastLinearToSlowEaseIn;

              final tween = Tween(
                begin: begin,
                end: end,
              ).chain(
                CurveTween(curve: curve),
              );

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
          routes: [
            GoRoute(
              path: Routes.accountSettingsPage.key,
              name: Routes.accountSettingsPage.value,
              parentNavigatorKey: rootNavigatorKey,
              builder: (context, state) => AccountSettingsPage(
                key: state.pageKey,
              ),
            )
          ],
        )
      ],
      redirect: (_, state) {
        final authenticated = notifier.isAuthenticated;
        final emailVerified = notifier.emailVerified;
        final inProfileCompletion = notifier.isInProfileCompletion;
        final profileCompleted = notifier.isProfileCompleted;

        final locationInLogin = state.location.startsWith(Routes.landing.key);

        if (!locationInLogin && !inProfileCompletion) {
          return !authenticated ? Routes.landing.key : null;
        }

        if (authenticated) {
          if (emailVerified != null && !emailVerified) {
            return '${Routes.finishProfile.key}/${Routes.verifyEmail.key}';
          }
          if (!profileCompleted) {
            return Routes.finishProfile.key;
          }
          if (profileCompleted) {
            return Routes.mainPage.key;
          }
        }

        return null;
      },
      errorPageBuilder: (context, state) => NoTransitionPage<void>(
        child: Scaffold(
          body: Center(
            child: Text('Error: ${state.error}'),
          ),
        ),
      ),
    );
  },
);
