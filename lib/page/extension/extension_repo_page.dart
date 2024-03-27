import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_repo_page_controller.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/util/image_helper.dart';

/// 官方插件
class ExtensionRepoPage extends GetView<ExtensionRepoPageController> {
  const ExtensionRepoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionRepoPageController());
    MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Install Extension"),
      ),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state!.length,
          itemBuilder: (context, index) {
            Extension extension = state[index];
            return buildItem(theme, extension);
          },
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
        vertical: 10.h,
        horizontal: 20.w,
      ),
      child: Row(
        children: [
          buildLogo(extension.icon!),
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
                  extension.version,
                  style: theme.tipsStyle,
                ),
                Text(
                  extension.type.toString(),
                  style: theme.tipsStyle,
                ),
                Text(
                  extension.lang,
                  style: theme.tipsStyle,
                ),
              ],
            ),
          ),
          20.horizontalSpace,
          IconButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xFFF3F3F3),
              ),
            ),
            onPressed: () {},
            icon: ImageHelper.getSvg(
              "arrow-down",
              size: 18.sp,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLogo(String image) {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        //color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: CachedNetworkImageProvider(image),
        ),
      ),
    );
  }
}
