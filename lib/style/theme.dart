import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme extends ThemeExtension<MyTheme> {
  @override
  ThemeExtension<MyTheme> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<MyTheme> lerp(
      covariant ThemeExtension<MyTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  const MyTheme({
    required this.titleStyle,
    required this.bodyStyle,
    required this.tipsStyle,
    required this.cardColor,
  });

  /// 主题内容字体
  final TextStyle? titleStyle;

  /// 主题内容字体
  final TextStyle? bodyStyle;

  /// 主题内容字体
  final TextStyle? tipsStyle;

  /// 卡片颜色
  final Color? cardColor;

  /// 白色主题
  static final light = MyTheme(
    titleStyle: TextStyle(
      fontSize: 18.sp,
      color: const Color(0xFF333333),
    ),
    bodyStyle: TextStyle(
      fontSize: 16.sp,
      color: const Color(0xFF333333),
    ),
    tipsStyle: TextStyle(
      fontSize: 13.sp,
      color: const Color(0xFF666666),
    ),
    cardColor:const Color(0xFFEFEFEF),
  );

  /// 黑色主题
  static final dark = MyTheme(
    titleStyle: TextStyle(
      fontSize: 18.sp,
      color: const Color(0xFFEEEEEE),
    ),
    bodyStyle: TextStyle(
      fontSize: 16.sp,
      color: const Color(0xFFEEEEEE),
    ),
    tipsStyle: TextStyle(
      fontSize: 13.sp,
      color: const Color(0xFFBBBBBB),
    ),
    cardColor:const Color(0xFF666666),
  );
}
