import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/search.dart';
import 'package:guyhub/page/search/search_input_page_logic.dart';
import 'package:guyhub/util/image_helper.dart';

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
                  showMenu(search);
                },
              );
            },
          ),
        ),
        onEmpty: Obx(
          //当输入了搜索词 并且 没有焦点 显示 空数据
          () => controller.key.isNotEmpty && !controller.focus.value
              ? buildEmpty()
              //获得焦点显示引导，没有焦点不显示任何东西(刚进入界面)
              : controller.focus.value
                  ? buildIntro()
                  : const SizedBox(),
        ),
        onError: (e) => buildError(),
      ),
    );
  }

  /// 绘制推荐搜索界面
  Widget buildIntro() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("最近搜索:"),
          6.verticalSpace,
          Wrap(
            spacing: 10.h,
            children: [
              ActionChip(
                onPressed: () {
                  controller.editingController.text = "寄生兽";
                  controller.search();
                },
                label: const Text("寄生兽:灰色战队"),
                avatar: ImageHelper.getSvg("video"),
              ),
              ActionChip(
                onPressed: () {
                  controller.editingController.text = "变形金刚4";
                  controller.search();
                },
                label: const Text("变形金刚4"),
                avatar: ImageHelper.getSvg("bt"),
              ),
              ActionChip(
                onPressed: () {
                  controller.editingController.text = "普罗米修斯";
                  controller.search();
                },
                label: const Text("普罗米修斯"),
                avatar: ImageHelper.getSvg("book"),
              ),
              ActionChip(
                onPressed: () {
                  controller.editingController.text = "星际穿越";
                  controller.search();
                },
                label: const Text("星际穿越"),
                avatar: ImageHelper.getSvg("music"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 绘制错误界面
  Widget buildError() {
    return const Center(
      child: Text(
        "无法链接到服务器",
        style: TextStyle(
          color: Color(0xFF999999),
        ),
      ),
    );
  }

  /// 绘制错误界面
  Widget buildEmpty() {
    return const Center(
      child: Text(
        "无相关内容",
        style: TextStyle(
          color: Color(0xFF999999),
        ),
      ),
    );
  }

  /// 构造标题
  AppBar buildAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20.w,
      toolbarHeight: 80.h,
      title: Hero(
        tag: "search",
        child: Focus(
          onFocusChange: (value) {
            controller.focus.value = value;
          },
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
              hintText: "输入你要搜索的关键词",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF666666),
              ),
              suffixIconConstraints: BoxConstraints(minWidth: 50.w),
              //suffixIcon: ImageHelper.getSvg(
              //  "search",
              //  color: const Color(0xFF333333),
              //  size: 22.sp,
              //),
              suffixIcon: buildAction(),
              //suffix: Obx(
              //  () => GestureDetector(
              //    onTap: controller.onAction,
              //    child: controller.key.isEmpty
              //        ? const Text("取消")
              //        : const Text("清除"),
              //  ),
              //),
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
                  width: 1,
                  color: Color(0xFF555555),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 输入框操作区域
  Widget buildAction() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 删除按钮
        Obx(
          () => controller.focus.value && controller.key.value.isNotEmpty
              ? IconButton(
                  onPressed: controller.clear,
                  icon: Icon(
                    Icons.close,
                    size: 18.sp,
                    color: const Color(0xFF888888),
                  ),
                )
              : const SizedBox(),
        ),

        SizedBox(
          height: 14.h,
          child: const VerticalDivider(
            width: 1,
            color: Color(0xFF888888),
          ),
        ),

        // 搜索按钮
        Obx(
          () => TextButton(
            onPressed: controller.key.isNotEmpty ? controller.search : null,
            child: const Text("搜索"),
          ),
        )
      ],
    );
  }

  ///搜索项目
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

  /// 显示弹出菜单
  void showMenu(Search search) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: 10.h,
        ),
        margin: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              search.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            20.verticalSpace,
            FilledButton(
              onPressed: () {
                controller.download(search);
              },
              child: const Text("打开"),
            ),
            TextButton(
              onPressed: () {
                controller.copy(search);
              },
              child: const Text("复制"),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}
