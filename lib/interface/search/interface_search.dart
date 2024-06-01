import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:guyhub/util/http.dart';

/// 种子搜索接口
abstract class InterfaceSearch {
  /// 官网
  abstract String url;

  /// 初始化是否完成
  RxBool initSuccess = RxBool(false);

  /// Web控制器
  InAppWebViewController? controller;

  /// 构造函数
  InterfaceSearch(
    InAppWebViewController inAppWebViewController,
    this.onFinish,
  ) {
    controller = inAppWebViewController;
    controller!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }

  /// 搜索
  void search(String keyword);

  /// 解析数据
  Future analysis(WebUri? webUri);

  /// 数据加载完成
  void Function(ServiceResultData result)? onFinish;

  /// 页面加载完成
  void onWebViewLoadStop(WebUri? webUri) async {
    if (webUri?.rawValue == url) {
      initSuccess.value = true;
    } else {
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
