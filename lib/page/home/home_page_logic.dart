
import 'package:get/get.dart';
import 'package:guyhub/model/moive.dart';
import 'package:guyhub/model/plugin_app.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class HomePageLogic extends GetxController {
  late List<PluginApp> apps = List.empty(growable: true);

  /// 播放器
  late final player = Player();

  /// 播放器控制器
  late VideoController controller = VideoController(player);

  /// 新片速递
  var moives = RxList.empty(growable: true);

  @override
  void onInit() {
    super.onInit();

    //player.open(Media('asset:///assets/1.mp4'));

    apps.add(PluginApp(
        name: "unsplash", logo: "http://milimili.tv/style/images/logo.png"));
    apps.add(PluginApp(
        name: "Milimili.tv", logo: "http://milimili.tv/style/images/logo.png"));

    loadData();
  }

  void loadData() async {
    moives.add(Moive(
      avatar: "https://m.ykimg.com/052600005F11576B4265870E0F150BAC",
      name: "我不是药神",
      directo: "文牧野",
      performer: "徐峥/周一围/王传君/谭卓/章宇/杨新鸣/王砚辉/贾晨飞/李乃文/王佳佳/龚蓓苾/宁",
      tags: 
      "2018 中国大陆 剧情",
    ));

    moives.add(Moive(
      avatar: "https://puep.qpic.cn/coral/Q3auHgzwzM4fgQ41VTF2rMZMCQThIesLggaaebZiboPicpcD8E88Y0MQ/0",
      name: "海王2：失落的王国",
      directo: "温子仁",
      performer: "杰森·莫玛/帕特里克·威尔森/叶海亚·阿卜杜勒-迈丁/安珀·赫德/妮可·基德曼/兰道尔·朴/特穆拉·",
      tags: 
      "2023美国 动作/ 科幻/ 奇幻/ 冒险",
    ));

     moives.add(Moive(
      avatar: "https://puui.qpic.cn/vcover_vt_pic/0/porrg8osobrmvs81567583706/220",
      name: "蝴蝶效应",
      directo: "埃里克·布雷斯/J.麦基·格鲁伯",
      performer: "阿什顿·库彻/艾米·斯马特/约翰·帕特里克·阿梅多利/罗根·勒曼",
      tags: 
      "2004美国悬疑/ 科幻/ 惊悚/ 剧情",
    ));

    //const userAgent =
    //    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.6045.160 Safari/537.36';

    //const HttpHeaders = {
    //  'Accept-Encoding': '',
    //  'Accept':
    //      'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
    //  'Accept-Language': '',
    //  'Connection': 'keep-alive',
    //  'Cache-Control': 'max-age=0',
    //  'Cookie':
    //      'cf_clearance=4CxLCianbp4iAT7aXk8q.p2HbPp_ltymgCH0OvTjbkk-1715871385-1.0.1.1-NHZv0PUMYq9hKbLiFu4GxPnfrKlKdwyACPIjhmqESyXjMo1T7OKlAa4UiuMvooPXM6rqqBJMHlaXy_0CXctXKA; Path=/; Expires=Fri, 16-May-25 14:56:25 GMT; Domain=.www.freeok.vip; HttpOnly; Secure; SameSite=None; Partitioned',
    //  'Host': 'www.freeok.vip',
    //  'Origin': 'https://www.freeok.vip/',
    //  'Referer': 'https://www.freeok.vip',
    //  'User-Agent': userAgent
    //};

    ////加载电影 最近新上线
    ////https://www.freeok.vip/v-type/1.html
    //String url1 =
    //    "https://www.freeok.vip/cdn-cgi/challenge-platform/h/g/jsd/r/884c33d56a41cf65";

    //String url = "https://www.freeok.vip/";
    //var result = await Http.get(url, headers: HttpHeaders);
    //if (result.success) {
    //  var doc = parse(result.data);
    //  var items = doc.getElementsByClassName("module-items");
    //}
  }
}
