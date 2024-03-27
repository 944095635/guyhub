import 'dart:convert';

import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/util/http.dart';

class ExtensionRepoPageController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    super.onInit();
    value = List.empty(growable: true);
    loadData();
  }

  void loadData() async {
    //https://miru-repo.0n0.dev/index.json
    //TODO 目前写死
    String url = "https://miru-repo.0n0.dev/index.json";

    ServiceResultData result = await Http.get(url);
    value!.clear();
    if (result.success) {
      var data = json.decode(result.data);
      for (var item in data) {
        Extension extension = Extension.fromJson(item);
        //SettingKey.enableNSFW 是否开启 限定内容
        //extensions.removeWhere((element) => element['nsfw'] == "true");
        value!.add(extension);
      }
      if (value!.isNotEmpty) {
        change(value, status: RxStatus.success());
      } else {
        change(value, status: RxStatus.empty());
      }
    } else {
      change(value, status: RxStatus.error());
    }
  }
}
