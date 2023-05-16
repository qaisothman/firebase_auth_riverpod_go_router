import 'package:uuid/uuid.dart';

class CoreHelpers {
  static String get newId => const Uuid().v4().replaceAll('-', '');
}
