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
import 'package:guyhub/widget/common.dart';

/// 扩展插件页面
class ExtensionPage extends GetView<ExtensionPageController> {
  const ExtensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionPageController());
    return Scaffold(
      //Extensions
      appBar: PreferredSize(
        preferredSize: const Size(0, kToolbarHeight),
        child: getFilterWidget(
          child: Obx(
            () => buildAppBarText(
              "插件列表 [${controller.count.value}]",
              backgroundColor: MyTheme.get(context).aeroColor,
              actions: [
                IconButton(
                  onPressed: controller.changeView,
                  icon: ImageHelper.getSvg(
                    "grid_view",
                    color: MyTheme.get(context).bodyStyle.color,
                  ),
                ),
                IconButton(
                  onPressed: controller.addExtension,
                  icon: ImageHelper.getSvg(
                    "app_store",
                    color: MyTheme.get(context).bodyStyle.color,
                  ),
                ),
                10.horizontalSpace,
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: controller.obx(
        (state) => EasyRefresh(
          onRefresh: () {
            controller.onRefresh();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => GridView.builder(
                cacheExtent: 5000,
                itemCount: state!.length,
                itemBuilder: (context, index) {
                  Extension extension = state[index];
                  return buildItem(context, extension);
                },
                gridDelegate: getDelegate(),
              ),
            ),
          ),
        ),
        onEmpty: const Text("你还没有安装任何插件"),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount getDelegate() {
    int column;
    double? ratio;
    switch (controller.mode.value) {
      case GridViewMode.two:
        column = 2;
        break;
      case GridViewMode.two_:
        column = 2;
        ratio = 4 / 5;
        break;
      case GridViewMode.three:
        column = 3;
        break;
      case GridViewMode.three_:
        column = 3;
        ratio = 4 / 5;
        break;
      case GridViewMode.four:
        column = 4;
        break;
      default:
        column = 3;
    }

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: column,
      childAspectRatio: ratio ?? 1,
    );
  }

  Widget buildItem(BuildContext context, Extension extension) {
    MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller.openExtension(extension);
      },
      child: Container(
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
                    child: Center(
                      child: buildLogo(extension.icon),
                    ),
                  ),
                  Text(
                    extension.name,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: theme.bodyColor,
                    ),
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
            sigmaX: 50,
            sigmaY: 50,
          ),
          child: Transform.scale(
            scale: 3,
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
