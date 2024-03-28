import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';

/// 资源详情页面
class ExtensionRunDetailPageController extends GetxController {
  late ExtensionListItem item;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments;
  }
}
