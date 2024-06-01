import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/frame/frame_page.dart';
import 'package:guyhub/util/extension.dart';
import 'package:guyhub/util/path.dart';
import 'package:media_kit/media_kit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "盖呀",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }

  void init() async {
    /// 插件初始化
    await PathUtils.ensureInitialized();
    ExtensionUtils.ensureInitialized();
    MediaKit.ensureInitialized();

    //跳转到不同的页面
    await Future.delayed(Durations.extralong4);
    Get.offAll(
      () => const FramePage(),
      transition: Transition.fadeIn,
    );
  }
}
