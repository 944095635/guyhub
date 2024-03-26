import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:guyhub/plugin/unsplash/home/home_page_controller.dart';
import 'package:guyhub/plugin/unsplash/model/upsplash_image.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  String? get tag => "unsplash";

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController(), tag: tag);
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Unsplash"),
          bottom: TabBar(
            onTap: (value) {
              controller.changeType(value);
            },
            tabs: const [
              Tab(
                text: "最新",
              ),
              Tab(
                text: "春",
              ),
              Tab(
                text: "自然",
              ),
              Tab(
                text: "壁纸",
              ),
              Tab(
                text: "动物",
              ),
              Tab(
                text: "旅行",
              ),
              Tab(
                text: "建筑与室内设计",
              ),
              Tab(
                text: "纹理与图案",
              ),
              Tab(
                text: "时尚与美容",
              ),
              Tab(
                text: "人",
              )
            ],
            isScrollable: true,
            tabAlignment: TabAlignment.start,
          ),
        ),
        body: controller.obx(
          (state) => EasyRefresh(
            onLoad: () async {
              await controller.loadData();
            },
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              itemCount: state.length,
              itemBuilder: (context, index) {
                UpsplashImage image = state[index];
                return AspectRatio(
                  aspectRatio: image.width / image.height,
                  child: CachedNetworkImage(
                    imageUrl: image.urls["small"],
                  ),
                );
              },
            ),
            //child: ListView.builder(
            //  itemCount: state.length,
            //  itemBuilder: (context, index) {
            //    UpsplashImage image = state[index];
            //    return AspectRatio(
            //      aspectRatio: image.width / image.height,
            //      child: CachedNetworkImage(
            //        imageUrl: image.urls["small"],
            //      ),
            //    );
            //  },
            //),
          ),
        ),
      ),
    );
  }

  Widget build1(BuildContext context) {
    Get.put(HomePageController(), tag: tag);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unsplash"),
      ),
    );
  }
}
