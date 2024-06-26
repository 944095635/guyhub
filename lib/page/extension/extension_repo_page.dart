import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_repo_page_controller.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/util/image_helper.dart';
import 'package:guyhub/widget/appbar.dart';

/// 官方插件
class ExtensionRepoPage extends GetView<ExtensionRepoPageController> {
  const ExtensionRepoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionRepoPageController());
    return Scaffold(
      //Install Extension
      appBar: buildAppBarText(
        "安装插件",
        actions: [
          IconButton(
            onPressed: controller.installAll,
            icon: ImageHelper.getSvg(
              "app_store",
              color: MyTheme.get(context).bodyStyle.color,
            ),
          ),
          10.horizontalSpace,
        ],
      ),
      body: controller.obx(
        (state) => ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: state!.length,
          itemBuilder: (context, index) {
            Extension extension = state[index];
            return buildItem(context, extension);
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Extension extension) {
    MyTheme theme = MyTheme.get(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(
        bottom: 10.h,
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
                  "版本号:${extension.version}",
                  style: theme.tipsStyle,
                ),
                Text(
                  "${extension.lang}，${extension.type}",
                  style: theme.tipsStyle,
                ),
                Text(
                  "少儿不宜:${extension.nsfw ?? ""}",
                  style: theme.tipsStyle,
                ),
              ],
            ),
          ),
          20.horizontalSpace,
          Obx(
            () => extension.install.value
                ? TextButton(
                    onPressed: () {
                      controller.uninstall(extension);
                    },
                    child: const Text(
                      "卸载",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      controller.install(extension);
                    },
                    child: extension.download.value
                        ? SizedBox(
                            width: 14.w,
                            height: 14.w,
                            child: const CircularProgressIndicator(),
                          )
                        : const Text("安装"),
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
