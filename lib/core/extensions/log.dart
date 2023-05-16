import 'package:flutter/foundation.dart' show debugPrint;

extension Log on Object {
  void log() => debugPrint(toString());
}
