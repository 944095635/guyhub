import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          buildCard(),
        ],
      ),
    );
  }

  Widget buildIconButton(String icon) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 12.w,
            height: 12.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFF8E8E8E),
              BlendMode.srcIn,
            ),
          ),
          6.horizontalSpace,
          const Text(
            "2",
            style: TextStyle(
              color: Color(0xFF8E8E8E),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard() {
    return HCard(
      child: Column(
        children: [
          /// 头像 用户名 和 动态
          /// 动态带图
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/1.jpg",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: buildIconButton("assets/svg/export.svg")),
                Center(
                  child: const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 1,
                    ),
                  ),
                ),
                Expanded(child: buildIconButton("assets/svg/message.svg")),
                Center(
                  child: const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 1,
                    ),
                  ),
                ),
                Expanded(child: buildIconButton("assets/svg/message.svg")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HCard extends StatelessWidget {
  const HCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFF9F9F9),
            blurRadius: 30,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
