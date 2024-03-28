import 'package:flutter_js/extensions/fetch.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_run_detail_page.dart';
import 'package:guyhub/util/extension.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExtensionRunPageController extends GetxController with StateMixin<List> {
  /// 当前页
  late int pageIndex = 1;

  /// 当前扩展
  late Extension extension;

  /// 运行服务
  JavascriptRuntime? _runtime;

  @override
  void onInit() {
    super.onInit();
    value = List.empty(growable: true);
    extension = Get.arguments;
    init();
  }

  void init() async {
    // 初始化runtime
    _runtime = getJavascriptRuntime();

    // 加载脚本&注册回调
    await ExtensionUtils.registerExtension(
      runtime: _runtime!,
      extension: extension,
    );

    value!.clear();

    /// 加载首页数据
    List<ExtensionListItem> list = await ExtensionUtils.latest(_runtime!);
    value!.addAll(list);
    change(value, status: RxStatus.success());
  }

  @override
  void onClose() {
    _runtime?.dispose();
  }

  Future loadMore() async {
    pageIndex++;

    /// 加载首页数据
    List<ExtensionListItem> list =
        await ExtensionUtils.latest(_runtime!, pageIndex: pageIndex);
    value!.addAll(list);
    change(value, status: RxStatus.success());
  }

  void toDetail(ExtensionListItem item) {
    Get.to(
      () => const ExtensionRunDetailPage(),
      arguments: [_runtime, item, extension],
    );
  }
}
