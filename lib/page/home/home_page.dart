import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guyhub/model/plugin_app.dart';
import 'package:guyhub/plugin/unsplash/home/home_page.dart' as upsplash;
import 'package:guyhub/page/home/home_page_controller.dart';
import 'package:guyhub/widget/appbar.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: buildAppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              "HOME",
              style: const TextStyle(
                fontFamily: "AvantGarde",
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            padding: EdgeInsets.only(left: 10.w),
            tabs: [
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
          ),
        ),
        body: ListView(
          children: [
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
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 30,
                    width: 30,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/music.svg",
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
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
                child: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: const Text(
                    "Extensions",
                    style: TextStyle(
                      fontFamily: "AvantGarde",
                    ),
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
        ),
      ),
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
