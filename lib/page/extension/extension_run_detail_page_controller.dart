import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_js/extensions/fetch.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/util/extension.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// 资源详情页面
class ExtensionRunDetailPageController extends GetxController
    with StateMixin<ExtensionDetail> {
  late ExtensionListItem item;

  late Extension extension;

  late JavascriptRuntime _runtime;

  @override
  void onInit() {
    super.onInit();
    _runtime = Get.arguments[0];
    item = Get.arguments[1];
    extension = Get.arguments[2];
    init();
  }

  void init() async {
    //加载该资源的详情
    value = await ExtensionUtils.detail(_runtime, item.url);
    //debugPrint(detail?.title);
    change(value, status: RxStatus.success());
  }

  void play(ExtensionEpisode url) async {
    SmartDialog.showLoading();
    Object? d = await ExtensionUtils.watch(_runtime, extension, url.url);
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
  }

  void play1(ExtensionListItem item) async {
    SmartDialog.showLoading();
    ExtensionDetail detail = await ExtensionUtils.detail(_runtime, item.url);
    debug(detail.title);
    Object? d = await ExtensionUtils.watch(
        _runtime, extension, detail.episodes!.first.urls.first.url);
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
