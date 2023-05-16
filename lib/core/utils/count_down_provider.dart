import 'dart:async' show StreamSubscription;

import 'package:flutter/foundation.dart' show ValueNotifier;

class CountDown extends ValueNotifier<int> {
  CountDown({required int from}) : super(from) {
    subscription = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen(
          (value) => this.value = value,
        );
  }

  late final StreamSubscription<int> subscription;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
