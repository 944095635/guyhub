import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_page_controller.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/util/image_helper.dart';
import 'package:guyhub/widget/appbar.dart';

/// 扩展插件页面
class ExtensionPage extends GetView<ExtensionPageController> {
  const ExtensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionPageController());
    MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return Scaffold(
      //Extensions
      appBar: buildAppBarText(
        "插件列表",
        actions: [
          IconButton(
            onPressed: controller.addExtension,
            icon: ImageHelper.getSvg("app_store"),
          ),
          10.horizontalSpace,
        ],
      ),
      body: controller.obx(
        (state) => EasyRefresh(
          onRefresh: () {
            controller.reload();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: state!.length,
              itemBuilder: (context, index) {
                Extension extension = state[index];
                return buildItem(theme, extension);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                //childAspectRatio: 4 / 5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(MyTheme theme, Extension extension) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.borderColor),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          buildBackground(extension.icon),
          Container(
            decoration: BoxDecoration(
              color: theme.aeroColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(child: buildLogo(extension.icon)),
                ),
                Text(
                  extension.name,
                  style: theme.bodyStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (extension.isNsfw) ...{
            //显示18禁图标
            Positioned(
              top: 6,
              right: 6,
              child: build18Logo(),
            )
          }
        ],
      ),
    );
  }

  /// 背景图
  Widget buildBackground(String? image) {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 30,
            sigmaY: 30,
          ),
          child: Transform.scale(
            scale: 1.4,
            child: CachedNetworkImage(
              imageUrl: image,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildLogo(String? image) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 50.w,
              height: 50.w,
            ),
          )
        : Container(
          alignment: Alignment.center,
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: ImageHelper.getSvg(
              "apps",
              color: Colors.deepPurple,
              size: 22.sp,
            ),
          );
  }

  /// 18禁 图标
  Widget build18Logo() {
    return buildCard(
      color: Colors.pinkAccent,
      child: const Text(
        "18+",
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
    );
  }

  Widget buildCard({
    required Color color,
    required Widget child,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(3),
      ),
      child: child,
    );
  }
}
