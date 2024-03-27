import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';

class ExtensionRunPageController extends GetxController with StateMixin {
  late Extension extension;

  late int pageIndex = 1;

  @override
  void onInit() {
    super.onInit();
    value = List.empty(growable: true);
    extension = Get.arguments;
  }
}
