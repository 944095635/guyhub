import 'package:get/get.dart';
import 'package:guyhub/page/extension/extension_repo_page.dart';
import 'package:guyhub/util/extension.dart';

class ExtensionPageController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    super.onInit();
    value = List.empty(growable: true);
    loadData();
  }

  void loadData() async {
    //读取已经安装的插件
    var data = ExtensionUtils.getExtensions();
    value!.clear();
    for (var item in data) {
      value!.add(item);
    }
    change(value,
        status: value!.isNotEmpty ? RxStatus.success() : RxStatus.empty());
  }

  void reload() {
    loadData();
  }

  void addExtension() async {
    await Get.to(() => const ExtensionRepoPage());
    loadData();
  }
}
