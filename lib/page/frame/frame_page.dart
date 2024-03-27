import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/extension/extension_page.dart';
import 'package:guyhub/page/frame/frame_page_controller.dart';
import 'package:guyhub/page/home/home_page.dart';
import 'package:guyhub/util/image_helper.dart';
import 'package:guyhub/widget/common.dart';

class FramePage extends GetView<FramePageController> {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FramePageController());
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.selectPageIndex.value,
          children: const [
            HomePage(),
            ExtensionPage(),
            Text("data"),
          ],
        ),
      ),
      bottomNavigationBar: getFilterWidget(
        child: Obx(
          () => BottomNavigationBar(
            onTap: (index) {
              controller.selectPageIndex.value = index;
            },
            currentIndex: controller.selectPageIndex.value,
            items: [
              BottomNavigationBarItem(
                activeIcon: buildHomeButton(
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                ),
                icon: buildHomeButton(
                  Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                label: "首页",
              ),
              BottomNavigationBarItem(
                activeIcon: buildExtensionButton(
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                ),
                icon: buildExtensionButton(
                  Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                label: "插件",
              ),
              BottomNavigationBarItem(
                activeIcon: buildMyButton(
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                ),
                icon: buildMyButton(
                  Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                label: "我的",
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 首页按钮
  Widget buildHomeButton(Color? color) {
    return ImageHelper.getSvg(
      "frame_home",
      color: color,
    );
  }

  /// 插件
  Widget buildExtensionButton(Color? color) {
    return ImageHelper.getSvg(
      "frame_archive",
      color: color,
    );
  }

  /// 我的按钮
  Widget buildMyButton(Color? color) {
    return ImageHelper.getSvg(
      "frame_my",
      color: color,
    );
  }
}
