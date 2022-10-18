import 'dart:ui';

import 'colors_utils.dart';

extension ColorExtension on String {
  Color get c => ColorsUtil.hexToColor(this);
}
