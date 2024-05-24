import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart'
    show FocusNode, TextEditingController, debugPrint;
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/search.dart';
import 'package:guyhub/util/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
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
  }

  @override
  void onClose() {
    super.onClose();
    focusNode.dispose();
    editingController.dispose();
  }

  Future<bool> loadData() async {
    String url = "https://cn.torrentkitty.ink/search/$key/$pageIndex";
    //请求首页
    ServiceResultData result = await Http.get(url);
    if (result.success) {
      List<Search> newData = [];
      debugPrint(result.data);
      Document document = parse(result.data);
      //table id="archiveResult"
      Element? archiveResult = document.getElementById("archiveResult");
      if (archiveResult != null) {
        List<Element> trs = archiveResult.getElementsByTagName("tr");
        for (var tr in trs) {
          //第一行可能是标题 action 有内容代表种子
          Element? taction = tr.getElementsByClassName("action").firstOrNull;
          if (taction?.innerHtml.isNotEmpty == true) {
            Search search = Search();
            Element? tname = tr.getElementsByClassName("name").firstOrNull;
            Element? tdate = tr.getElementsByClassName("date").firstOrNull;
            search.name = tname?.innerHtml ?? "";
            search.date = tdate?.innerHtml ?? "";

            List<Element> hrefs = taction!.getElementsByTagName("a");
            //rel
            for (var href in hrefs) {
              if (href.attributes["rel"] == "magnet") {
                search.magnet = href.attributes["href"];
              }
            }
            debugPrint("搜索到种子:${search.name}");
            newData.add(search);
          }
        }
      }
      if (newData.isNotEmpty) {
        value!.addAll(newData);
        //搜索完成，根据结果显示信息
        change(value, status: RxStatus.success());
        return true;
      } else {
        if (pageIndex == 1) {
          //搜索完成，但是没有数据
          change(value, status: RxStatus.empty());
        }
        return false;
      }
    } else {
      change(value, status: RxStatus.error());
      return false;
    }
  }

  /// 当前页面
  int pageIndex = 1;

  /// 开始搜索
  void search() {
    init.value = true;
    pageIndex = 1;
    value?.clear();
    change(value, status: RxStatus.loading());
    loadData();
  }

  Future loadMore() async {
    pageIndex++;
    return loadData();
  }

  /// 点击按钮
  void onAction() {
    if (key.isEmpty) {
      Get.back();
    } else {
      value?.clear();
      change(value, status: RxStatus.success());
      editingController.clear();
      focusNode.requestFocus();
    }
  }

  /// 下载
  void download(Search search) async {
    //String link =
    //    "thunder://QUFodHRwOi8vZGwxNTEuODBzLmltOjkyMC8xNzExL+i/veW/hi/ov73lv4YubXA0Wlo=";
    //Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(link));
    //intent.addCategory("android.intent.category.DEFAULT");
    //startActivity(intent);
    if (search.magnet?.isNotEmpty == true) {
      Uri uri = Uri.parse(search.magnet!);
      if (await canLaunchUrl(uri)) {
        await AndroidIntent(
          action: 'action_view',
          data: search.magnet!,
          //type: 'video/*',
        ).launch();
      }
    }
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