import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/moive.dart';
import 'package:guyhub/model/plugin_app.dart';
import 'package:guyhub/page/home/home_page_logic.dart';
import 'package:guyhub/style/style.dart';
import 'package:guyhub/widget/appbar.dart';

/// 首页
class HomePage extends GetView<HomePageLogic> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageLogic());
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: buildAppBar(
          title: buildAppTitle(),
          titleSpacing: 20.w,
          bottom: buildTabs(),
        ),
        body: buildBody(),
      ),
    );
  }

  /// App标题
  Widget buildAppTitle() {
    return Row(
      children: [
        const Text("丐帮"),
        5.horizontalSpace,
        const Text(
          "GUY",
          textHeightBehavior: TextHeightBehavior(
            applyHeightToLastDescent: false,
          ),
          style: TextStyles.avantGarde,
        ),
      ],
    );
  }

  /// Tab选项卡
  TabBar buildTabs() {
    return TabBar(
      isScrollable: true,
      padding: EdgeInsets.only(left: 10.w),
      tabs: const [
        Tab(
          text: "电影",
        ),
        Tab(
          text: "动漫",
        ),
        Tab(
          text: "漫画",
        ),
        Tab(
          text: "阅读",
        ),
      ],
    );
  }

  /// Body
  Widget buildBody() {
    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        buildTitle("新片速递"), 20.verticalSpace,
        ListView.separated(
          itemCount: controller.moives.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Moive moive = controller.moives[index];
            return buildMoiveItem(moive);
          },
          separatorBuilder: (BuildContext context, int index) =>
              10.verticalSpace,
        ),
        10.verticalSpace,
        build1(),
        200.verticalSpace,
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: const Text(
              "Dream.Machine",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "AvantGarde",
              ),
            ),
          ),
        ),
        200.verticalSpace,
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 30,
                width: 30,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/music.svg",
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: const Text(
                  "ETH 99",
                  style: TextStyle(
                    fontFamily: "AvantGarde",
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: FilledButton(
            onPressed: () {},
            child: const Text(
              "插件",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: FilledButton(
            onPressed: () {},
            child: const Text(
              "Extensions",
              textHeightBehavior: TextHeightBehavior(
                applyHeightToLastDescent: false,
              ),
              style: TextStyle(
                fontFamily: "AvantGarde",
              ),
            ),
          ),
        ),
        //ListView.builder(
        //  shrinkWrap: true,
        //  itemCount: controller.apps.length,
        //  itemBuilder: (context, index) {
        //    PluginApp app = controller.apps[index];
        //    return GestureDetector(
        //      child: buildItem(app),
        //      onTap: () {
        //        Get.to(() => const upsplash.HomePage());
        //      },
        //    );
        //  },
        //),
      ],
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 封面
  /// 名称
  /// 导演 + 主演
  /// 标签
  Widget buildMoiveItem(Moive moive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: CachedNetworkImage(
            imageUrl: moive.avatar,
            width: 100.w,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                moive.name,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "导演：" + moive.directo,
              ),
              Text(
                "主演：" + moive.performer,
              ),
              Text(
                moive.tags,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget build1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: CachedNetworkImage(
            imageUrl:
                "https://puep.qpic.cn/coral/Q3auHgzwzM4fgQ41VTF2rFYFibvzyukMvkiagAbL7O0n4LiauoIQ63CaQ/0",
            width: 100.w,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "死亡谷",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "导演：丁晟",
              ),
              Text(
                "主演：杨幂/于谦/田雨/余皑磊/李九霄/黄小蕾",
              ),
              Wrap(
                spacing: 10.w,
                children: [
                  Text(
                    "2021",
                  ),
                  Text(
                    "中国大陆",
                  ),
                  Text(
                    "剧情/喜剧/运动",
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildItem(PluginApp app) {
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 53, 52, 52),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(app.name),
      ),
    );
  }

  Widget buildCard({required Widget child}) {
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 30,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
