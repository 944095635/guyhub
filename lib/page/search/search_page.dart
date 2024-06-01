import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled/padding_extension.dart';
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
      appBar: AppBar(toolbarHeight: 0),
      body: buildBody(),
    );
  }

  /// 绘制整体
  Widget buildBody() {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Text(
            "G",
            style: TextStyles.avantGarde.copyWith(
              fontSize: 800.sp,
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
              buildLogo(),
              60.verticalSpace,
              paddingH20(
                child: buildSearchBox(),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// 绘制LOGO
  Widget buildLogo() {
    return Text(
      "G",
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToLastDescent: false,
      ),
      style: TextStyles.avantGarde.copyWith(
        fontSize: 100.sp,
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
        height: 50.h,
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
}
