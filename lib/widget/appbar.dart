import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/util/image_helper.dart';

AppBar buildAppBarText(
  String txt, {
  List<Widget>? actions,
}) {
  return buildAppBar(
    title: Text(txt),
    actions: actions,
  );
}

AppBar buildAppBar({
  Widget? title,
  List<Widget>? actions,
}) {
  return AppBar(
    leading: Navigator.canPop(Get.context!)
        ? IconButton(
            icon: ImageHelper.getSvg(
              "back",
              color: Colors.black,
              size: 24.sp,
            ),
            onPressed: () {
              Navigator.of(Get.context!).maybePop();
            },
          )
        : null,
    title: title,
    actions: actions,
  );
}
