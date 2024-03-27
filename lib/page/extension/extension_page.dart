import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/extension/extension_repo_page.dart';
import 'package:guyhub/util/image_helper.dart';

/// 扩展插件页面
class ExtensionPage extends GetView {
  const ExtensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extensions"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: ImageHelper.getSvg("add_square"),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const ExtensionRepoPage());
            },
            icon: ImageHelper.getSvg("mouse"),
          ),
          10.horizontalSpace,
        ],
      ),
    );
  }
}
