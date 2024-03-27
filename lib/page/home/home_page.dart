import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/plugin_app.dart';
import 'package:guyhub/plugin/unsplash/home/home_page.dart' as upsplash;
import 'package:guyhub/page/home/home_page_controller.dart';
import 'package:media_kit_video/media_kit_video.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ListView.builder(
        itemCount: controller.apps.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return buildCard(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Video(
                    controller: controller.controller,
                    controls: NoVideoControls,
                  ),
                ),
              ),
            );
          }
          PluginApp app = controller.apps[index - 1];
          return GestureDetector(
            child: buildItem(app),
            onTap: () {
              Get.to(() => const upsplash.HomePage());
            },
          );
        },
      ),
    );
  }

  Widget buildItem(PluginApp app) {
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFF9F9F9),
              blurRadius: 30,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(app.name),
      ),
    );
  }

  Widget buildCard({required Widget child}) {
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFF9F9F9),
              blurRadius: 30,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
