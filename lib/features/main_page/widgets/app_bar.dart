import 'package:firebase_auth_riverpod_go_router/product/router/routes.dart';
import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPageAppBar extends StatefulWidget {
  const MainPageAppBar({super.key});

  @override
  State<MainPageAppBar> createState() => _MainPageAppBarState();
}

class _MainPageAppBarState extends State<MainPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        GestureDetector(
          onTap: () => context.push(Routes.user.key),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: context.theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
