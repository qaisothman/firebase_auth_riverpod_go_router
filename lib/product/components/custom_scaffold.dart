import 'package:firebase_auth_riverpod_go_router/product/theme/theme_manager.dart';
import 'package:flutter/material.dart';


class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.floatingActionButton,
    super.key,
  });
  final Widget body;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        appBar: appBar,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: body,
      ),
    );
  }
}
