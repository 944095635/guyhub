import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_page_controller.dart';
import 'package:guyhub/page/extension/widget/extension_item.dart';
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
                itemCount: state!.length,
                itemBuilder: (context, index) {
                  Extension extension = state[index];
                  return ExtensionItem(
                    extension: extension,
                    onTap: () {
                      controller.openExtension(extension);
                    },
                  );
                },
                gridDelegate: getDelegate(),
              ),
            ),
          ),
        ),
        onEmpty: Center(
          child: Text(
            "未安装任何插件",
            style: TextStyle(color: MyTheme.get(context).bodyColor),
          ),
        ),
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
}
