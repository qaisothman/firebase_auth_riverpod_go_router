import 'package:firebase_auth_riverpod_go_router/product/l10n/arb/app_localizations.dart';
import 'package:firebase_auth_riverpod_go_router/product/product.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

/// The main app widget.
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReceiptAppState();
}

class _ReceiptAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Auth Riverpod GoRouter',
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en', 'US'),
      theme: lightTheme,
      builder: (context, child) => Material(
        child: Layout(
          child: Builder(
            builder: (context) => child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
