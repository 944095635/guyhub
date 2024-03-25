/*玻璃容器*/
import 'dart:ui';

import 'package:flutter/material.dart';

/* 毛玻璃的颜色 */
const Color glassColor = Color.fromARGB(200, 255, 255, 255);

Widget getFilterWidget({
  Widget? child,
  double sigmaX = 12,
  double sigmaY = 12,
  Color? color, //是否具备颜色
  EdgeInsets? padding,
}) {
  return ClipRect(
    //背景模糊化
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: Container(
        color: color ?? glassColor,
        padding: padding,
        child: child,
      ),
    ),
  );
}
