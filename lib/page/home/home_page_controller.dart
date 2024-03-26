import 'package:get/get.dart';
import 'package:guyhub/model/plugin_app.dart';

class HomePageController extends GetxController {
  late List<PluginApp> apps = List.empty(growable: true);

  @override
  void onInit() {
    super.onInit();

    apps.add(PluginApp(name: "unsplash",logo:"http://milimili.tv/style/images/logo.png"));
    apps.add(PluginApp(name: "Milimili.tv",logo:"http://milimili.tv/style/images/logo.png"));
  }
}
