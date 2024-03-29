import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/plugin_app.dart';
import 'package:guyhub/plugin/unsplash/home/home_page.dart' as upsplash;
import 'package:guyhub/page/home/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ListView.builder(
        itemCount: controller.apps.length,
        itemBuilder: (context, index) {
          PluginApp app = controller.apps[index];
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
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 53, 52, 52),
              blurRadius: 10,
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
          boxShadow: const [
            BoxShadow(
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
