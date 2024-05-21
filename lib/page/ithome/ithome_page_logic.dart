import 'package:get/get.dart';
import 'package:guyhub/util/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class IthomePageLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // 轮播列表
  var focusList = RxList.empty(growable: true);
  var news = RxList.empty(growable: true);

  /// 加载首页数据
  Future loadData() async {
    //请求首页
    ServiceResultData result = await Http.get("https://www.ithome.com/");
    if (result.success) {
      Document document = parse(result.data);
      List<Element> owlstages =
          document.getElementsByClassName("lazyOwl owl-lazy");
      for (Element element in owlstages) {
        //<img class="lazyOwl owl-lazy" data-src="https://img.ithome.com/newsuploadfiles/focus/d80e1777-cce1-4764-9f6f-3888b81f7ea4.jpg?x-bce-process=image/format,f_auto" alt="微软最强 Surface Laptop 登场,，配骁龙 X Elite / Plus 芯片">
        String image = element.attributes["data-src"] ?? "";
        String title = element.attributes["alt"] ?? "";
        String href = element.parent?.attributes["href"] ?? "";
        News focusOwl = News(
          title: title,
          image: image,
          href: href,
          body: '',
          time: '',
        );
        focusList.add(focusOwl);
      }

      //https://www.ithome.com/blog/
      ServiceResultData resultNews =
          await Http.get("https://www.ithome.com/blog/");
      if (resultNews.success) {
        Document document1 = parse(resultNews.data);
        Element? listBox = document1.getElementById("list");
        List<Element>? list = listBox?.getElementsByTagName("li");
        if (list != null) {
          for (var element in list) {
            Element? m = element.getElementsByClassName("m").firstOrNull;
            String body = m?.innerHtml ?? "";

            Element? stateTody =
                element.getElementsByClassName("state tody").firstOrNull;
            String time = stateTody?.innerHtml ?? "";

            Element? img = element.getElementsByTagName("img").firstOrNull;
            String image = img?.attributes["data-original"] ?? "";

            Element? titleElement =
                element.getElementsByClassName("title").firstOrNull;
            String title = titleElement?.innerHtml ?? "";
            String href = titleElement?.attributes["href"] ?? "";

            News newsItem = News(
              body: body,
              href: href,
              title: title,
              image: image,
              time: time,
            );
            news.add(newsItem);
          }
        }
      }
    }
  }

  Future onRefresh() async {
    news.clear();
    focusList.clear();
    await loadData();
  }
}

/// IT之家轮播
class IthomeFocusOwl {
  late String image;
  late String title;
  late String href;
  late String time;
  IthomeFocusOwl({
    required this.image,
    required this.title,
    required this.href,
    required this.time,
  });
}

class News {
  late String image;
  late String title;
  String? body;
  late String href;
  String? time;
  News({
    this.body,
    required this.image,
    required this.title,
    required this.href,
    required this.time,
  });
}
