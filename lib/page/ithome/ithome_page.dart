import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/ithome/ithome_page_logic.dart';

/// IT之家页面
class IthomePage extends GetView<IthomePageLogic> {
  const IthomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IthomePageLogic());
    return Scaffold(
      appBar: AppBar(
        title: const Text("新闻"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: EasyRefresh(
          onRefresh: () async {
            await controller.onRefresh();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150.h,
                  child: Obx(() => PageView.builder(
                        itemCount: controller.focusList.length,
                        itemBuilder: (context, index) {
                          News focusOwl = controller.focusList[index];
                          return CachedNetworkImage(imageUrl: focusOwl.image);
                        },
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: 20.verticalSpace,
              ),
              DecoratedSliver(
                decoration: const BoxDecoration(color: Colors.white),
                sliver: Obx(
                  () => SliverList.separated(
                    itemCount: controller.news.length,
                    itemBuilder: (context, index) {
                      News news = controller.news[index];
                      return buildNewsItem(news);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 20,
                        indent: 20.w,
                        endIndent: 20.w,
                        color: const Color(0xFFF8F8F8),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 绘制新闻子项
  Widget buildNewsItem(News news) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(news.title),
                10.verticalSpace,
                Text(
                  news.time ?? "",
                  style: const TextStyle(
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: news.image,
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }
}
