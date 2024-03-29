import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme extends ThemeExtension<MyTheme> {
  @override
  ThemeExtension<MyTheme> copyWith() {
    return MyTheme(
      titleStyle: titleStyle,
      bodyStyle: bodyStyle,
      tipsStyle: tipsStyle,
      cardColor: cardColor,
      iconColor: iconColor,
      iconButtonStyle: iconButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle,
      aeroColor: aeroColor,
      shadowColor: shadowColor,
      borderColor: borderColor,
    );
  }

  @override
  ThemeExtension<MyTheme> lerp(
      covariant ThemeExtension<MyTheme>? other, double t) {
    if (other is! MyTheme) {
      return this;
    }
    return MyTheme(
      titleStyle: titleStyle,
      bodyStyle: bodyStyle,
      tipsStyle: tipsStyle,
      cardColor: cardColor,
      iconColor: iconColor,
      iconButtonStyle: iconButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle,
      aeroColor: aeroColor,
      shadowColor: shadowColor,
      borderColor: borderColor,
    );
  }

  const MyTheme({
    required this.titleStyle,
    required this.bodyStyle,
    required this.tipsStyle,
    required this.cardColor,
    required this.iconColor,
    required this.iconButtonStyle,
    required this.secondaryButtonStyle,

    /// 颜色
    this.aeroColor,
    required this.borderColor,
    required this.shadowColor,
  });

  /// ****************************************************************************************************
  /// 白色主题
  /// 文本内容 13px ，颜色 #333
  /// 文本提示内容 12px ,颜色 #666
  ///
  /// 卡片颜色
  final Color? iconColor;
  // 半透明颜色 白色的白 70 ，黑色的 黑54
  final Color? aeroColor;
  // 阴影颜色 很淡  Color.fromARGB(255, 245, 245, 245)  / Color.fromARGB(20, 245, 245, 245)
  final Color shadowColor;
  // 边框颜色 很淡  const Color.fromARGB(20, 140, 140, 140)  / const Color.fromARGB(20, 140, 140, 140)
  final Color borderColor;

  ///
  /// 黑色主题：
  ///   卡片 25252F

  /// 内容标题
  final TextStyle? titleStyle;

  /// 内容
  final TextStyle? bodyStyle;

  /// 内容-提示信息
  final TextStyle? tipsStyle;

  /// 卡片颜色
  final Color? cardColor;

  /// 带背景色的图标按钮
  final ButtonStyle iconButtonStyle;

  /// 次要的按钮
  final ButtonStyle secondaryButtonStyle;

  /// ****************************************************************************************************

  /// 白色主题
  static final light = MyTheme(
    titleStyle: TextStyle(
      fontSize: 18.sp,
      color: const Color(0xFF333333),
    ),
    bodyStyle: TextStyle(
      fontSize: 13.sp,
      color: const Color(0xFF333333),
    ),
    tipsStyle: TextStyle(
      fontSize: 13.sp,
      color: const Color(0xFF666666),
    ),

    /// 卡片的背景色
    cardColor: Colors.white,
    aeroColor: Colors.white70,
    shadowColor: const Color.fromARGB(255, 245, 245, 245),
    borderColor: const Color.fromARGB(20, 140, 140, 140),

    /// 图标颜色
    iconColor: const Color(0xFF666666),
    iconButtonStyle: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color(0xFFFEFEFE),
      ),
    ),

    /// 次要按钮
    secondaryButtonStyle: const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(
        Color(0xFF666666),
      ),
    ),
  );

  //-------------------------------------------------------------------------------------------

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
    cardColor: const Color(0xFF25252F),
    aeroColor: Colors.black45,
    shadowColor: Colors.black,
    borderColor: Colors.black,

    /// 图标颜色
    iconColor: const Color(0xFF666666),
    iconButtonStyle: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color(0xFFF3F3F3),
      ),
    ),

    /// 次要按钮
    secondaryButtonStyle: const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(
        Color(0xFF666666),
      ),
    ),
  );
}
