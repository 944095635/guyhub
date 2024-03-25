import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/pages/frame/frame_page_controller.dart';
import 'package:guyhub/pages/home/home_page.dart';
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
          ],
        ),
      ),
      bottomNavigationBar: getFilterWidget(
        child: Obx(
          () => BottomNavigationBar(
            onTap: (index) {
              controller.selectPageIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: glassColor,
            currentIndex: controller.selectPageIndex.value,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 11.sp,
            unselectedFontSize: 11.sp,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home),
                label: "Home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
