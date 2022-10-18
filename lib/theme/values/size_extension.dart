/// 适配宽高
/// author：jingluo
/// date：2021.6.20

import '../utils/screen_util.dart';

extension SizeExtension on num {
  /// 适配宽高
  double get dp => ScreenUtil.getInstance().getAdapterSize(toDouble());

  /// 适配字体
  double get sp => ScreenUtil.getInstance().getAdapterSize(toDouble());

  /// 屏幕宽高的百分比
  double get wp => ScreenUtil.getInstance().screenWidth * toDouble();

  /// 屏幕宽高的百分比
  double get hp => ScreenUtil.getInstance().screenHeight * toDouble();
}
