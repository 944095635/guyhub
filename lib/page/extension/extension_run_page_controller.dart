import 'package:flutter_js/extensions/fetch.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
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

  void play(ExtensionListItem item) async {
    SmartDialog.showLoading();
    ExtensionDetail detail = await ExtensionUtils.detail(_runtime!, item.url);
    debug(detail.title);
    Object? d = await ExtensionUtils.watch(
        _runtime!, extension, detail.episodes!.first.urls.first.url);
    SmartDialog.dismiss();
    switch (extension.type) {
      case ExtensionType.bangumi:
        ExtensionBangumiWatch dd = d as ExtensionBangumiWatch;
        debug(dd.toString());
        launchMobileExternalPlayer(dd.url, "other");
      //final result = ExtensionBangumiWatch.fromJson(data);
      //result.headers ??= await _defaultHeaders;
      case ExtensionType.manga:
      //final result = ExtensionMangaWatch.fromJson(data);
      //result.headers ??= await _defaultHeaders;
      default:
      //return ExtensionFikushonWatch.fromJson(data);
    }
    debug(d.toString());
  }

  Future<void> launchMobileExternalPlayer(String playUrl, String player) async {
    switch (player) {
      case "vlc":
        await _launchExternalPlayer("vlc://$playUrl");
        break;
      case "other":
        await AndroidIntent(
          action: 'action_view',
          data: playUrl,
          type: 'video/*',
        ).launch();
        break;
    }
  }

  _launchExternalPlayer(String url) async {
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Failed to launch $url");
    }
  }
}
