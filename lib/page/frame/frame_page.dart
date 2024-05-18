import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/extension/extension_page.dart';
import 'package:guyhub/page/frame/frame_page_controller.dart';
import 'package:guyhub/page/home/home_page.dart';
import 'package:guyhub/page/search/search_page.dart';
import 'package:guyhub/util/image_helper.dart';

class FramePage extends GetView<FramePageController> {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FramePageController());
    //MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.selectPageIndex.value,
          children: const [
            SearchPage(),
            HomePage(),
            ExtensionPage(),
            Text("data"),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.selectPageIndex.value = index;
          },
          currentIndex: controller.selectPageIndex.value,
          items: [
            BottomNavigationBarItem(
              activeIcon: buildSearchButton(
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              ),
              icon: buildSearchButton(
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              ),
              label: "搜索",
            ),
            BottomNavigationBarItem(
              activeIcon: buildHomeButton(
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              ),
              icon: buildHomeButton(
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              ),
              label: "首页",
            ),
            BottomNavigationBarItem(
              activeIcon: buildExtensionButton(
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              ),
              icon: buildExtensionButton(
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              ),
              label: "插件",
            ),
            BottomNavigationBarItem(
              activeIcon: buildMyButton(
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              ),
              icon: buildMyButton(
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              ),
              label: "我的",
            ),
          ],
        ),
      ),
    );
  }

  /// 搜索按钮
  Widget buildSearchButton(Color? color) {
    return ImageHelper.getSvg(
      "search2",
      color: color,
      size: 26.sp,
    );
  }

  /// 首页按钮
  Widget buildHomeButton(Color? color) {
    return ImageHelper.getSvg(
      "home",
      color: color,
      size: 26.sp,
    );
  }

  /// 插件
  Widget buildExtensionButton(Color? color) {
    return ImageHelper.getSvg(
      "ext",
      color: color,
      size: 26.sp,
    );
  }

  /// 我的按钮
  Widget buildMyButton(Color? color) {
    return ImageHelper.getSvg(
      "user",
      color: color,
      size: 26.sp,
    );
  }
}
