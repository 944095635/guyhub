import 'package:get/get.dart';
import 'package:guyhub/model/plugin_app.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class HomePageController extends GetxController {
  late List<PluginApp> apps = List.empty(growable: true);

  /// 播放器
  late final player = Player();

  /// 播放器控制器
  late VideoController controller = VideoController(player);

  @override
  void onInit() {
    super.onInit();

    //player.open(Media('asset:///assets/1.mp4'));

    apps.add(PluginApp(
        name: "unsplash", logo: "http://milimili.tv/style/images/logo.png"));
    apps.add(PluginApp(
        name: "Milimili.tv", logo: "http://milimili.tv/style/images/logo.png"));
  }
}
