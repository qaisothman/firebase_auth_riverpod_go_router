import 'dart:developer' show log;

import 'package:hooks_riverpod/hooks_riverpod.dart';

class StateLogger extends ProviderObserver {
  const StateLogger();
  @override
  void didUpdateProvider(
    ProviderBase<void> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  provider: ${provider.name ?? provider.runtimeType},
  oldValue: $previousValue,
  newValue: $newValue
}
''');
    super.didUpdateProvider(
      provider,
      previousValue,
      newValue,
      container,
    );
  }
}
