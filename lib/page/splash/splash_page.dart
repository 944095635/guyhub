import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/frame/frame_page.dart';
import 'package:guyhub/util/extension.dart';
import 'package:guyhub/util/path.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Guy Hub"),
      ),
    );
  }

  void init() async {
    /// 插件初始化
    await PathUtils.ensureInitialized();
    ExtensionUtils.ensureInitialized();

    //跳转到不同的页面
    await Future.delayed(Durations.extralong4);
    Get.offAll(
      () => const FramePage(),
      transition: Transition.fadeIn,
    );
  }
}
