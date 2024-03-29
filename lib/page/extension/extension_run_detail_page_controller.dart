import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/service/extension_service.dart';

/// 资源详情页面
class ExtensionRunDetailPageController extends GetxController
    with StateMixin<ExtensionDetail> {
  late ExtensionListItem item;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments;
    init();
  }

  void init() async {
    //加载该资源的详情
    value = await ExtensionService.loadDetail(item);
    if (value !=null) {
      change(value, status: RxStatus.success());
    } else {
      change(value, status: RxStatus.error());
    }
  }

  void play(ExtensionEpisode url){}

  //void play(ExtensionEpisode url) async {
  //  SmartDialog.showLoading();
  //  Object? d = await ExtensionUtils.watch(_runtime, extension, url.url);
  //  SmartDialog.dismiss();
  //  switch (extension.type) {
  //    case ExtensionType.bangumi:
  //      ExtensionBangumiWatch dd = d as ExtensionBangumiWatch;
  //      debug(dd.toString());
  //      launchMobileExternalPlayer(dd.url, "other");
  //    //final result = ExtensionBangumiWatch.fromJson(data);
  //    //result.headers ??= await _defaultHeaders;
  //    case ExtensionType.manga:
  //    //final result = ExtensionMangaWatch.fromJson(data);
  //    //result.headers ??= await _defaultHeaders;
  //    default:
  //    //return ExtensionFikushonWatch.fromJson(data);
  //  }
  //}

  //void play1(ExtensionListItem item) async {
  //  SmartDialog.showLoading();
  //  ExtensionDetail detail = await ExtensionUtils.detail(_runtime!, item.url);
  //  debug(detail.title);
  //  Object? d = await ExtensionUtils.watch(
  //      _runtime!, extension, detail.episodes!.first.urls.first.url);
  //  SmartDialog.dismiss();
  //  switch (extension.type) {
  //    case ExtensionType.bangumi:
  //      ExtensionBangumiWatch dd = d as ExtensionBangumiWatch;
  //      debug(dd.toString());
  //      launchMobileExternalPlayer(dd.url, "other");
  //    //final result = ExtensionBangumiWatch.fromJson(data);
  //    //result.headers ??= await _defaultHeaders;
  //    case ExtensionType.manga:
  //    //final result = ExtensionMangaWatch.fromJson(data);
  //    //result.headers ??= await _defaultHeaders;
  //    default:
  //    //return ExtensionFikushonWatch.fromJson(data);
  //  }
  //  debug(d.toString());
  //}

  //Future<void> launchMobileExternalPlayer(String playUrl, String player) async {
  //  switch (player) {
  //    case "vlc":
  //      await _launchExternalPlayer("vlc://$playUrl");
  //      break;
  //    case "other":
  //      await AndroidIntent(
  //        action: 'action_view',
  //        data: playUrl,
  //        type: 'video/*',
  //      ).launch();
  //      break;
  //  }
  //}

  //_launchExternalPlayer(String url) async {
  //  if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
  //    throw Exception("Failed to launch $url");
  //  }
  //}
}
