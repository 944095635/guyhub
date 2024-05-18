import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 搜索输入页面
class SearchInputPage extends StatelessWidget {
  const SearchInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(250, 250, 250, 1),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "寄生兽：灰色部队",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
                6.verticalSpace,
                Row(
                  children: [
                    Text(
                      "数量: 7",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),
                    6.horizontalSpace,
                    Text(
                      "大小:6.01 GB",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
                6.verticalSpace,
                const Text(
                  "2024-04-06 05:05:51",
                  style: TextStyle(
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 构造标题
  AppBar buildAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20.w,
      toolbarHeight: 60.h,
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
            /// `EdgeInsets.fromLTRB(12, 20, 12, 12)` when [isDense] is true
            /// and `EdgeInsets.fromLTRB(12, 24, 12, 16)` when [isDense] is false.
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            hintText: "搜索",
            suffixIconConstraints: BoxConstraints(minWidth: 50.w),
            //suffixIcon: ImageHelper.getSvg(
            //  "search",
            //  color: const Color(0xFF333333),
            //  size: 22.sp,
            //),
            suffixText: "取消",
            fillColor: const Color(0x22FFFFFF),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
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
    );
  }
}
