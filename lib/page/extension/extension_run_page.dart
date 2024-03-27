import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/extension/extension_run_page_controller.dart';
import 'package:guyhub/widget/appbar.dart';

/// 插件运行界面
class ExtensionRunPage extends GetView<ExtensionRunPageController> {
  const ExtensionRunPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionRunPageController());
    return Scaffold(
      appBar: buildAppBarText(controller.extension.name),
      body: controller.obx(
        (state) => EasyRefresh(
          onRefresh: () {
            //controller.reload();
          },
          child: ListView.builder(
            itemCount: state!.length,
            itemBuilder: (context, index) {
              return const Text("data");
              //return buildItem(theme, extension);
            },
          ),
        ),
      ),
    );
  }
}
