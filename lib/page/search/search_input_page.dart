import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/search.dart';
import 'package:guyhub/page/search/search_input_page_logic.dart';

/// 搜索输入页面
class SearchInputPage extends GetView<SearchInputPageLogic> {
  const SearchInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchInputPageLogic());
    return Scaffold(
      appBar: buildAppbar(),
      //让键盘盖住内容-防止loading跳动
      resizeToAvoidBottomInset: false,
      body: controller.obx(
        (data) => EasyRefresh(
          onLoad: () async {
            bool more = await controller.loadMore();
            return more ? IndicatorResult.success : IndicatorResult.noMore;
          },
          child: ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              Search search = data[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: buildItem(search),
                onTap: () {
                  controller.download(search);
                },
              );
            },
          ),
        ),
        onEmpty: Obx(
          () => controller.init.value
              ? const Center(
                  child: Text(
                    "无相关内容",
                    style: TextStyle(
                      color: Color(0xFF999999),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
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
          focusNode: controller.focusNode,
          controller: controller.editingController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            controller.search();
          },
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
            suffix: Obx(
              () => GestureDetector(
                onTap: controller.onAction,
                child: controller.key.isEmpty
                    ? const Text("取消")
                    : const Text("清除"),
              ),
            ),
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

  Widget buildItem(Search search) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            search.name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          6.verticalSpace,
          Text(
            search.date,
            style: const TextStyle(
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
