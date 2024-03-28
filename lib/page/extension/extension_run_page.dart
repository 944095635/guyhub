import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_run_page_controller.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/widget/appbar.dart';

/// 插件运行界面
class ExtensionRunPage extends GetView<ExtensionRunPageController> {
  const ExtensionRunPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionRunPageController());
    MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return Scaffold(
      appBar: buildAppBarText(controller.extension.name),
      body: SizedBox.expand(
        child: controller.obx(
          (state) => EasyRefresh(
            onRefresh: () {
              //controller.reload();
            },
            onLoad: () async {
              await controller.loadMore();
            },
            child: ListView.separated(
              //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //  crossAxisCount: 3,
              //  mainAxisSpacing: 10,
              //  crossAxisSpacing: 10,
              //  childAspectRatio: 9 / 16,
              //),
              padding: const EdgeInsets.all(10),
              itemCount: state!.length,
              itemBuilder: (context, index) {
                ExtensionListItem item = state[index];
                return buildItem(theme, item);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  10.verticalSpace,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(MyTheme theme, ExtensionListItem item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ExtensionRunPage(), arguments: item);
      },
      child: AspectRatio(
        aspectRatio: 21 / 9,
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  child: item.cover != null
                      ? CachedNetworkImage(
                          imageUrl: item.cover!,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        overflow: TextOverflow.fade,
                        style: theme.bodyStyle,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      item.update ?? "",
                      style: theme.tipsStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
