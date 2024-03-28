import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_run_detail_page_controller.dart';
import 'package:guyhub/widget/appbar.dart';

/// 资源详情页
class ExtensionRunDetailPage extends GetView<ExtensionRunDetailPageController> {
  const ExtensionRunDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExtensionRunDetailPageController());
    return Scaffold(
      appBar: buildAppBarText(controller.item.title),
      body: controller.obx((state) => ListView(
            children: [
              Text(state!.toJson().toString()),
              const Text("线路:"),
              for (var item in state.episodes!) ...{
                Text(item.title),
                for (ExtensionEpisode url in item.urls) ...{
                  FilledButton(
                    onPressed: () {
                      controller.play(url);
                    },
                    child: Text(url.name),
                  )
                },
                const Divider()
              }
            ],
          )),
    );
  }
}
