import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/plugin_app.dart';
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
          return buildItem(app);
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
}
