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
          Center(
            child: GestureDetector(
              onTap: () async {
                await Get.to(
                  () => const SearchInputPage(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 1200),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: "search",
                        child: Container(
                          height: 48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF333333),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: ImageHelper.getSvg(
                          "search",
                          color: const Color(0xFF333333),
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Center( //    child: TextField(
          //      decoration: InputDecoration(
          //        hintText: "SEARCH ANYTHING",
          //        hintStyle: TextStyles.avantGarde,
          //        suffixIconConstraints: BoxConstraints(minWidth: 50.w),
          //        suffixIcon: ImageHelper.getSvg(
          //          "search",
          //          color: const Color(0xFF333333),
          //          size: 22.sp,
          //        ),
          //        fillColor: const Color(0x22FFFFFF),
          //        filled: true,
          //        enabledBorder: OutlineInputBorder(
          //          borderSide: const BorderSide(
          //            width: 2,
          //            color: Color(0xFF555555),
          //          ),
          //          borderRadius: BorderRadius.circular(10),
          //        ),
          //        focusedBorder: OutlineInputBorder(
          //          borderSide: const BorderSide(
          //            width: 2,
          //            color: Color(0xFF555555),
          //          ),
          //          borderRadius: BorderRadius.circular(10),
          //        ),
          //      ),
          //    ),
          //  ),
          //  child: Padding(
          //    padding: EdgeInsets.symmetric(horizontal: 20.w),
         
          //),
        ],
      ),
    );
  }
}
