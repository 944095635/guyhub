import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Column(
            children: [
              120.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "丐帮",
                    style: TextStyles.avantGarde.copyWith(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  6.horizontalSpace,
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                      "GUY",
                      style: TextStyles.avantGarde.copyWith(
                        fontSize: 60.sp,
                      ),
                    ),
                  ),
                ],
              ),
              80.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "SEARCH ANYTHING",
                    hintStyle: TextStyles.avantGarde,
                    suffixIconConstraints: BoxConstraints(minWidth: 50.w),
                    suffixIcon: ImageHelper.getSvg(
                      "search",
                      color: const Color(0xFF333333),
                      size: 22.sp,
                    ),
                    fillColor: const Color(0x22FFFFFF),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF555555),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF555555),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStatePropertyAll(Size.fromHeight(80.h)),
                      shape: const WidgetStatePropertyAll(
                        CircleBorder(
                          side: BorderSide(color: Color(0xFF333333), width: 2),
                        ),
                      ),
                      //backgroundColor:
                      //    const WidgetStatePropertyAll(Colors.transparent),
                      //backgroundColor:
                      //    const WidgetStatePropertyAll(Color(0xFF252525)),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
