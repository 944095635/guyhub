import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guyhub/style/style.dart';

/// 搜索输入页面
class SearchInputPage extends StatelessWidget {
  const SearchInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 20.w,
        toolbarHeight: 80,
        title: Hero(
          tag: "search",
          //child: Container(
          //  height: 40.h,
          //  width: double.infinity,
          //  decoration: BoxDecoration(
          //    border: Border.all(
          //      color: Color(0xFF333333),
          //      width: 2,
          //    ),
          //    borderRadius: BorderRadius.circular(50),
          //  ),
          //),

          child: TextField(
            decoration: InputDecoration(
              hintText: "SEARCH ANYTHING",
              hintStyle: TextStyles.avantGarde,
              suffixIconConstraints: BoxConstraints(minWidth: 50.w),
              //suffixIcon: ImageHelper.getSvg(
              //  "search",
              //  color: const Color(0xFF333333),
              //  size: 22.sp,
              //),
              suffixText: "Cancel",
              fillColor: const Color(0x22FFFFFF),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF555555),
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF555555),
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
