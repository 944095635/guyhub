import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_repo_page.dart';
import 'package:guyhub/page/extension/extension_run_page.dart';
import 'package:guyhub/util/extension.dart';

class ExtensionPageController extends GetxController with StateMixin<List> {
  late Rx<GridViewMode> mode;

  /// 插件数量
  late RxInt count;

  @override
  void onInit() {
    super.onInit();
    count = 0.obs;
    mode = Rx(GridViewMode.three_);
    value = List.empty(growable: true);
    loadData();
  }

  void loadData() async {
    //读取已经安装的插件
    var data = await ExtensionUtils.getExtensions();
    value!.clear();
    for (var item in data) {
      value!.add(item);
    }
    count.value = value!.length;
    change(value,
        status: value!.isNotEmpty ? RxStatus.success() : RxStatus.empty());
  }

  /// 下拉刷新
  void onRefresh() {
    loadData();
  }

  void addExtension() async {
    await Get.to(() => const ExtensionRepoPage());
    loadData();
  }

  /// 运行插件
  void openExtension(Extension extension) async {
    await Get.to(() => const ExtensionRunPage(), arguments: extension);
  }

  /// 切换视图模式
  void changeView() {
    switch (mode.value) {
      case GridViewMode.two:
        mode.value = GridViewMode.two_;
        break;
      case GridViewMode.two_:
        mode.value = GridViewMode.three;
        break;
      case GridViewMode.three:
        mode.value = GridViewMode.three_;
        break;
      case GridViewMode.three_:
        mode.value = GridViewMode.four;
        break;
      case GridViewMode.four:
        mode.value = GridViewMode.two;
        break;
      default:
    }
  }
}

// 2 方
// 2 长
// 3 方
// 3 长
// 4 方
enum GridViewMode {
  two,
  two_,
  three,
  three_,
  four,
}
