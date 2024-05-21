import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/search/search_input_page.dart';
import 'package:guyhub/style/style.dart';
import 'package:guyhub/util/image_helper.dart';

/// 搜索主页
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Text(
              "G",
              style: TextStyles.avantGarde.copyWith(
                fontSize: 860.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1536ED),
              ),
            ),
          ),
          Container(
            color: const Color(0xCCFFFFFF),
          ),
          Positioned(
            top: 120.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "丐帮",
                  style: TextStyle(fontSize: 80.sp),
                ),
                60.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 30.w,
                  ),
                  child: buildSearchBox(),
                ),
                40.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: buildIntroRow([
                    buildIntroItem("image", "图片"),
                    buildIntroItem("music", "音乐"),
                    buildIntroItem("video", "媒体"),
                  ]),
                ),
                30.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: buildIntroRow([
                    buildIntroItem("bt", "种子"),
                    buildIntroItem("acg", "动漫"),
                    buildIntroItem("book", "书籍"),
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 搜索区域
  Widget buildSearchBox() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.to(
          () => const SearchInputPage(),
          transition: Transition.fadeIn,
          duration: Durations.extralong2,
        );
      },
      child: SizedBox(
        height: 48.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: "search",
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF666666),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text("搜索一切"),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: ImageHelper.getSvg(
                  "search",
                  color: const Color(0xFF666666),
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 介绍-行
  Widget buildIntroRow(List<Widget> rows) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rows,
    );
  }

  /// 单个介绍项目
  /// 上面图片
  /// 下面描述文字
  Widget buildIntroItem(String img, String title) {
    return Column(
      children: [
        ImageHelper.getSvg(
          img,
          size: 30.w,
        ),
        10.verticalSpace,
        Text(
          title,
        ),
      ],
    );
  }
}
