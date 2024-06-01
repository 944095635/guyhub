import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:guyhub/interface/search/interface_search.dart';
import 'package:guyhub/model/search.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

/// SKR-BT
class ImplementsSkrbt extends InterfaceSearch {
  @override
  String url = "https://skrbtgb.top";

  ImplementsSkrbt(super.inAppWebViewController, super.onFinish);

  @override
  void search(String keyword) {
    controller?.evaluateJavascript(source: '''
        document.querySelector('#search-form > div.input-group > input').value='$keyword'
        document.querySelector('#search-form > div.input-group > span > button').click()
    ''');
  }

  /// 会有3种状态
  /// 1.解析成功 有数据 [data]
  /// 2.解析成功 无数据 []
  /// 3.解析失败 Null
  @override
  Future<List?> analysis(WebUri? webUri) async {
    List<Search>? newData;
    //读取内容 解析
    String? html = await controller?.getHtml();
    if (html?.isNotEmpty == true) {
      newData = [];
      // 解析数据
      Document document = parse(html);
      //table id="archiveResult"
      List<Element>? list = document.getElementsByClassName("list-unstyled");
      if (list.isNotEmpty) {
        for (var item in list) {
          Search search = Search();
          var titleObj = item.querySelector("li > a.common-link");
          search.name = titleObj?.text ?? "NULL";
          search.magnet =
              item.querySelector("li.rrmi > a.common-link")?.attributes["href"];
          List<Element> infos = item.querySelectorAll("li.rrmi > span.rrmiv");
          if (infos.length == 3) {
            search.size = infos[0].text;
            search.count = infos[1].text;
            search.date = infos[2].text;
          }
          newData.add(search);
        }
      }
    }
    return newData;
  }
}
