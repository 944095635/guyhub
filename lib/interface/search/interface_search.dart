import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:guyhub/model/search.dart';
import 'package:guyhub/util/http.dart';

/// 种子搜索接口
abstract class InterfaceSearch {
  /// 官网
  abstract String url;

  /// 详情页关键词
  abstract String detail;

  /// 初始化是否完成
  bool initSuccess = false;

  /// Web控制器
  InAppWebViewController? controller;

  /// 构造函数
  InterfaceSearch(
    InAppWebViewController inAppWebViewController,
    this.onInit,
    this.onFinish,
    this.onOpen,
  ) {
    controller = inAppWebViewController;
    controller!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }

  /// 搜索
  void search(String keyword, int pageIndex);

  /// 打开一个详情页面
  void open(Search search);

  /// 解析数据
  Future analysis(WebUri? webUri);

  /// 解析数据
  Future analysisDetail();

  /// 数据加载完成
  void Function()? onInit;

  /// 数据加载完成
  void Function(ServiceResultData result)? onFinish;

  /// 获取下载地址
  void Function(String magnet)? onOpen;

  /// 页面加载完成
  void onWebViewLoadStop(WebUri? webUri) async {
    debugPrint("onWebViewLoadStop:${webUri?.rawValue ?? ""}");
    if (webUri?.rawValue.contains(url) == true && !initSuccess) {
      initSuccess = true;
      onInit?.call();
    } else if (webUri?.rawValue.contains("302") == true) {
      initSuccess = true;
      //onInit?.call();
    } else if (webUri?.rawValue.contains(detail) == true) {
      String? href = await analysisDetail();
      if (href != null) {
        onOpen?.call(href);
      }
    } else if (webUri?.rawValue.contains("search?keyword=") == true) {
      debugPrint("onWebViewLoadStop:${webUri!.rawValue}");
      ServiceResultData result = ServiceResultData();
      result.data = await analysis(webUri);

      /// 1.解析成功 有数据 [data]
      /// 2.解析成功 无数据 []
      /// 3.解析失败 Null
      /// 只要有数据代表成功
      if (result.data != null) {
        result.success = true;
      }
      onFinish?.call(result);
    }
  }

  /// 销毁
  void dispose() {
    controller?.dispose();
  }
}
