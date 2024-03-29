import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/page/extension/extension_run_detail_page.dart';
import 'package:guyhub/service/extension_service.dart';

class ExtensionRunPageController extends GetxController with StateMixin<List> {
  /// 当前页
  late int pageIndex = 1;

  /// 当前扩展
  late Extension extension;

  @override
  void onInit() {
    super.onInit();
    value = List.empty(growable: true);
    extension = Get.arguments;
    init();
  }

  void init() async {
    // 初始化服务
    await ExtensionService.run(extension);
    loadData();
  }

  Future loadData() async {
    value!.clear();
    // 加载首页数据
    List<ExtensionListItem> list = await ExtensionService.loadData(pageIndex);
    value!.addAll(list);
    change(value, status: RxStatus.success());
  }

  @override
  void dispose() {
    super.dispose();
    ExtensionService.stop();
  }

  Future loadMore() async {
    pageIndex++;
    await loadData();
  }

  /// 查看详情
  void toDetail(ExtensionListItem item) {
    Get.to(() => const ExtensionRunDetailPage(), arguments: item);
  }
}
