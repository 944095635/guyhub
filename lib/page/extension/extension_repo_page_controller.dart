import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/util/extension.dart';
import 'package:guyhub/util/http.dart';

class ExtensionRepoPageController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    super.onInit();
    value = List.empty(growable: true);
    loadData();
  }

  String host = "https://miru-repo.0n0.dev";

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
        if (ExtensionUtils.setups.contains(extension.package)) {
          //已经安装
          extension.install.value = true;
        }
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

  void install(Extension extension) async {
    if (!extension.download.value) {
      extension.download.value = true;
      //final url = MiruStorage.getSetting(SettingKey.miruRepoUrl) +"/repo/${widget.package}.js";
      final url = "$host/repo/${extension.package}.js";
      bool status = await ExtensionUtils.install(url);
      if (status) {
        extension.install.value = true;
        SmartDialog.showToast("安装成功");
      } else {
        SmartDialog.showNotify(msg: "安装失败", notifyType: NotifyType.error);
      }
      extension.download.value = false;
    }
  }

  void uninstall(Extension extension) async {
    var status = await ExtensionUtils.uninstall(extension);
    if (status) {
      extension.install.value = false;
      extension.download.value = false;
      SmartDialog.showToast("卸载成功");
    }
  }
}
