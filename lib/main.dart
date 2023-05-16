import 'package:firebase_auth_riverpod_go_router/core/utils/provider_logger.dart';
import 'package:firebase_auth_riverpod_go_router/firebase_options.dart';
import 'package:firebase_auth_riverpod_go_router/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      observers: [
        StateLogger(),
      ],
      child: MyApp(),
    ),
  );
}
