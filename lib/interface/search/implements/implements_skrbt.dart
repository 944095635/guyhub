import 'package:flutter/material.dart' show Characters, debugPrint;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:guyhub/interface/search/interface_search.dart';
import 'package:guyhub/model/search.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

/// SKR-BT
class ImplementsSkrbt extends InterfaceSearch {
  @override
  String url = "https://skrbtgb.top";
  //            https://skrbtgb.top/

  @override
  String detail = "/detail/";

  ImplementsSkrbt(
    super.inAppWebViewController,
    super.onInit,
    super.onFinish,
    super.onOpen,
  );

  @override
  void search(String keyword, int pageIndex) {
    if (pageIndex == 1) {
      debugPrint("onWebViewLoadStop:Load Page 1");
      controller?.evaluateJavascript(source: '''
        document.querySelector('#search-form > div.input-group > input').value='$keyword'
        document.querySelector('#search-form > div.input-group > span > button').click()
    ''');
    } else {
      debugPrint("onWebViewLoadStop:Load Page $pageIndex");
      controller?.evaluateJavascript(source: '''
        searchWithPath($pageIndex);
    ''');
    }
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
          search.name = item.querySelector("li > a.common-link")?.text ?? "";
          search.name = Characters(search.name).join("\u{200B}").trim();
          search.href =
              item.querySelector("li.rrmi > a.common-link")?.attributes["href"];
          List<Element> infos = item.querySelectorAll("li.rrmi > span.rrmiv");
          if (infos.length == 3) {
            search.size = infos[0].text;
            search.count = infos[1].text;
            search.date = infos[2].text;
          }

          search.files = [];
          List<Element> files = item.querySelectorAll("li.rrf");
          for (var fileElement in files) {
            SearchFile file = SearchFile();
            file.name = fileElement.querySelectorAll("span").first.text;
            file.name = Characters(file.name).join("\u{200B}").trim();
            file.size = fileElement.querySelectorAll("span").last.text;
            search.files.add(file);
          }
          newData.add(search);
        }
      }
    }
    return newData;
  }

  @override
  void open(Search search) async {
    controller?.evaluateJavascript(source: '''
        var links = document.querySelectorAll('li.rrmi > a.common-link');
        for (var i = 0; i < links.length; i++) {
          var href = links[i].getAttribute("href");
          if(href == "${search.href}")
          {
            links[i].setAttribute("target","_self");
            links[i].click();
          }
        }
    ''');
  }

  @override
  Future analysisDetail() async {
    String? html = await controller?.getHtml();
    if (html?.isNotEmpty == true) {
      // 解析数据
      Document document = parse(html);
      //table id="archiveResult"
      String? href = document.querySelector("#magnet")?.attributes["href"];
      await controller?.evaluateJavascript(source: '''
        window.history.back();
    ''');
      return href;
    }
  }
}
