import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_page_controller.dart';
import 'package:guyhub/page/extension/extension_run_page.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/util/image_helper.dart';
import 'package:guyhub/widget/appbar.dart';

/// 扩展插件页面
class ExtensionPage extends GetView<ExtensionPageController> {
  const ExtensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionPageController());
    MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return Scaffold(
      //Extensions
      appBar: buildAppBarText(
        "插件列表",
        actions: [
          IconButton(
            onPressed: controller.addExtension,
            icon: ImageHelper.getSvg("app_store"),
          ),
          10.horizontalSpace,
        ],
      ),
      body: controller.obx(
        (state) => EasyRefresh(
          onRefresh: () {
            controller.reload();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: state!.length,
              itemBuilder: (context, index) {
                Extension extension = state[index];
                return buildItem(theme, extension);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4 / 5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(MyTheme theme, Extension extension) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: const Color.fromARGB(19, 80, 80, 80)),
        boxShadow: const [
          BoxShadow(
            color: const Color.fromARGB(120, 220, 220, 220),
            blurRadius: 5,
          )
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            CachedNetworkImage(
              imageUrl: extension.icon!,
              fit: BoxFit.fill,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                color: Colors.white54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: build18Logo(),
                  ),
                  Expanded(
                    child: Center(child: buildLogo(extension.icon)),
                  ),
                  10.verticalSpace,
                  Text(
                    extension.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogo(String? image) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 60.w,
              height: 60.w,
            ),
          )
        : Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(10.r),
            ),
          );
  }

  Widget build18Logo() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Text(
        "18+",
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget buildCard(Color color, Widget child, {EdgeInsets? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(3),
      ),
      child: child,
    );
  }

  Widget buildCartoon() {
    return buildCard(
      const Color(0xFFDEDEDE),
      const Text(
        "动画",
        style: TextStyle(fontSize: 11),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
    );
  }
}
