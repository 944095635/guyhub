import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart'
    show Durations, FocusNode, TextEditingController;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/interface/search/implements/implements_skrbt.dart';
import 'package:guyhub/interface/search/interface_search.dart';
import 'package:guyhub/model/search.dart';
import 'package:guyhub/util/http.dart';
import 'package:url_launcher/url_launcher.dart';

/// 搜索页面
class SearchInputPageLogic extends GetxController
    with StateMixin<List<Search>> {
  /// 控制自动焦点
  late FocusNode focusNode;

  /// 控制清空内容
  late TextEditingController editingController;

  /// 是否已经开始搜索
  RxBool init = RxBool(false);

  /// 是否获取焦点
  RxBool focus = RxBool(false);

  /// 关键字
  RxString key = RxString("");

  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
    editingController = TextEditingController();
    editingController.addListener(() {
      key.value = editingController.text;
    });
    change(null, status: RxStatus.empty());
    value = List.empty(growable: true);

    //等待页面渲染完成
    SchedulerBinding.instance.addPostFrameCallback((e) {
      //debugPrint("addPostFrameCallback");
      Future.delayed(const Duration(milliseconds: 820))
          .then((v) => focusNode.requestFocus());
    });

    //controller = WebviewUtils.init();
  }

  @override
  void dispose() {
    super.dispose();
    searchApi?.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    focusNode.dispose();
    editingController.dispose();
  }

  /// 接口 - 搜索引擎
  InterfaceSearch? searchApi;

  /// 浏览器控制器初始化成功
  void initWebController(InAppWebViewController controller) {
    searchApi = ImplementsSkrbt(controller, onFinish);
  }

  /// 浏览器加载首页完成
  void onWebViewLoadStop(InAppWebViewController controller, WebUri? url) {
    searchApi!.onWebViewLoadStop(url);
  }

  /// 开始搜索
  void search() {
    focusNode.unfocus();
    init.value = true;
    pageIndex = 1;
    value?.clear();
    change(value, status: RxStatus.loading());
    //loadData();
    searchApi?.search(key.value);
  }

  /// 数据到达
  void onFinish(ServiceResultData result) {
    if (result.success) {
      if (key.isNotEmpty && result.data.isNotEmpty) {
        value!.addAll(result.data);
        //搜索完成，根据结果显示信息
        change(value, status: RxStatus.success());
      } else {
        if (pageIndex == 1) {
          //搜索完成，但是没有数据
          change(value, status: RxStatus.empty());
        }
      }
    } else {
      change(value, status: RxStatus.error());
    }

    /// 会有几种状态
    /// 1.网络异常或者解析失败，这种无法处理
    /// 2.网络正常解析正常，但是没有数据
    /// 3.存在数据
  }

  /// 当前页面
  int pageIndex = 1;

  Future loadMore() async {
    pageIndex++;
    searchApi?.search(key.value);
    //TODO 这里根据加载盛世剩余
    return true;
  }

  /// 清除输入
  void clear() {
    value?.clear();
    editingController.clear();

    //清空数据
    change(value, status: RxStatus.empty());
  }

  /// 点击按钮
  void onAction() {
    if (key.isEmpty) {
      back();
    } else {
      value?.clear();
      change(value, status: RxStatus.success());
      editingController.clear();
      focusNode.requestFocus();
    }
  }

  /// 后退返回上一页面
  void back() async {
    focusNode.unfocus();
    await Future.delayed(Durations.short2);
    Get.back();
  }

  /// 下载
  void download(Search search) async {
    //String link =
    //    "thunder://QUFodHRwOi8vZGwxNTEuODBzLmltOjkyMC8xNzExL+i/veW/hi/ov73lv4YubXA0Wlo=";
    //Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(link));
    //intent.addCategory("android.intent.category.DEFAULT");
    //startActivity(intent);
    if (search.magnet?.isNotEmpty == true) {
      if (Platform.isWindows) {
        Uri uri = Uri.parse(search.magnet!);
        launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (Platform.isAndroid) {
        openInAndroid(search);
      }
    }
  }

  /// 打开 - 安卓
  void openInAndroid(Search search) async {
    Get.back();
    try {
      await AndroidIntent(
        action: 'action_view',
        data: search.magnet!,
        //type: 'video/*',
      ).launch();
    } catch (e) {
      SmartDialog.showToast("打开失败,错误:$e");
    }
  }

  /// 复制到剪切板
  void copy(Search search) async {
    //SmartDialog.showLoading(msg: "复制到剪切板1");
    //await Future.delayed(Duration(seconds: 2));
    //SmartDialog.dismiss();
    //await Future.delayed(Duration(milliseconds: 250));
    //SmartDialog.showLoading(msg: "复制到剪切板2");
    //await Future.delayed(Duration(seconds: 2));
    //SmartDialog.dismiss();
    //return;
    ////
    ClipboardData clipboardData = ClipboardData(text: search.magnet!);
    await Clipboard.setData(clipboardData);
    SmartDialog.showToast("复制到剪切板");
    Get.back();
  }

//String link = "";
//Intent intent = new Intent(Intent.ACTION_VIEW,Uri.parse(link));
//intent.addCategory("android.intent.category.DEFAULT");
//startActivity(intent);
  //      await AndroidIntent(
  //        action: 'action_view',
  //        data: playUrl,
  //        type: 'video/*',
  //      ).launch();
}
