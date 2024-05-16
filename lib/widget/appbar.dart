import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/util/image_helper.dart';

AppBar buildAppBarText(
  String txt, {
  bool aero = false,
  List<Widget>? actions,
  Color? backgroundColor,
}) {
  return buildAppBar(
    title: Text(txt),
    actions: actions,
    backgroundColor: backgroundColor,
  );
}

AppBar buildAppBar({
  Widget? title,
  double? titleSpacing,
  double? toolbarHeight,
  List<Widget>? actions,
  Color? backgroundColor,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    leading: Navigator.canPop(Get.context!)
        ? IconButton(
            icon: ImageHelper.getSvg(
              "back",
              color: Theme.of(Get.context!).appBarTheme.foregroundColor,
              size: 24.sp,
            ),
            onPressed: () {
              Navigator.of(Get.context!).maybePop();
            },
          )
        : null,
    titleSpacing: titleSpacing,
    title: title,
    bottom: bottom,
    actions: actions,
    toolbarHeight: toolbarHeight,
    backgroundColor: backgroundColor,
  );
}
