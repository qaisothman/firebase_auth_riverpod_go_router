import 'package:firebase_auth_riverpod_go_router/features/main_page/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends ConsumerState<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CustomScrollView(
      slivers: [
        MainPageAppBar(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
