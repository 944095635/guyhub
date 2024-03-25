import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/pages/home/home_page.dart';

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
    //跳转到不同的页面
    await Future.delayed(Durations.extralong4);
    Get.offAll(
      () => const HomePage(),
      transition: Transition.fadeIn,
    );
  }
}
