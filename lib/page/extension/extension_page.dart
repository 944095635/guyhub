import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_page_controller.dart';
import 'package:guyhub/page/extension/extension_run_page.dart';
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
            icon: ImageHelper.getSvg("add"),
          ),
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
          child: ListView.builder(
            itemCount: state!.length,
            itemBuilder: (context, index) {
              Extension extension = state[index];
              return buildItem(theme, extension);
            },
          ),
        ),
      ),
    );
  }

  Widget buildItem(MyTheme theme, Extension extension) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 20.w,
      ),
      child: Row(
        children: [
          buildLogo(extension.icon),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  extension.name,
                  style: theme.bodyStyle,
                ),
                Text(
                  "${extension.lang}，${extension.type}",
                  style: theme.tipsStyle,
                ),
              ],
            ),
          ),
          20.horizontalSpace,
          TextButton(
            onPressed: () {
              Get.to(() => const ExtensionRunPage(), arguments: extension);
            },
            child: const Text(
              "启动",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogo(String? image) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 60.w,
              height: 60.w,
            ),
          )
        : Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(10.r),
            ),
          );
  }
}
