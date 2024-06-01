import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart'
    show Durations, FocusNode, TextEditingController;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  /// 控制上拉加载
  late EasyRefreshController easyRefreshController;

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
    easyRefreshController = EasyRefreshController(controlFinishLoad: true);
    //change(null, status: RxStatus.loading());
    value = List.empty(growable: true);

    //等待页面渲染完成
    // SchedulerBinding.instance.addPostFrameCallback((e) {
    //   //debugPrint("addPostFrameCallback");
    //   Future.delayed(const Duration(milliseconds: 820))
    //       .then((v) => focusNode.requestFocus());
    // });
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
    easyRefreshController.dispose();
  }

  /// 接口 - 搜索引擎
  InterfaceSearch? searchApi;

  /// 浏览器控制器初始化成功
  void initWebController(InAppWebViewController controller) {
    searchApi = ImplementsSkrbt(controller, onInitFinish, onFinish, onOpen);
  }

  /// 浏览器加载首页完成
  void onWebViewLoadStop(InAppWebViewController controller, WebUri? url) {
    searchApi!.onWebViewLoadStop(url);
  }

  /// 开始搜索
  void search() {
    focusNode.unfocus();
    pageIndex = 1;
    value?.clear();
    change(value, status: RxStatus.loading());
    //loadData();
    searchApi?.search(key.value, pageIndex);
  }

  /// 初始化
  void onInitFinish() {
    change(value, status: RxStatus.empty());
    focusNode.requestFocus();
  }

  /// 数据到达
  void onFinish(ServiceResultData result) {
    if (result.success) {
      easyRefreshController.finishLoad();
      if (key.isNotEmpty && result.data.isNotEmpty) {
        value!.addAll(result.data);
        for (Search element in result.data) {
          debugPrint("onWebViewLoadStop:${element.name}");
        }
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

  /// 下载
  void download(Search search) async {
    //Get.back();
    SmartDialog.showLoading(msg: "加载中");
    searchApi!.open(search);
    return;
    if (search.magnet?.isNotEmpty == true) {
      if (Platform.isWindows) {
        Uri uri = Uri.parse(search.magnet!);
        launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (Platform.isAndroid) {}
    }
  }

  /// 打开地址
  void onOpen(String magnet) {
    SmartDialog.dismiss();
    openInAndroid(magnet);
  }

  /// 打开 - 安卓
  void openInAndroid(String magnet) async {
    
    try {
      await AndroidIntent(
        action: 'action_view',
        data: magnet,
        //type: 'video/*',
      ).launch();
    } catch (e) {
      SmartDialog.showToast("打开失败,错误:$e");
    }
  }

  /// 当前页面
  int pageIndex = 1;
  void loadMore() async {
    pageIndex++;
    searchApi?.search(key.value, pageIndex);
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
