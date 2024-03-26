import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/splash/splash_page.dart';
import 'package:guyhub/widget/common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// 手机设置多分辨率支持
    if (Platform.isAndroid || Platform.isIOS) {
      ScreenUtil.init(
        context,
        designSize: const Size(375, 812),
      );
    }
    return GetMaterialApp(
      title: 'Guy Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark, //状态栏黑色图标
            systemNavigationBarColor: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: glassColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xFF000000),
          unselectedItemColor: const Color(0xFFAEAEAE),
          selectedLabelStyle: TextStyle(fontSize: 11.sp),
          unselectedLabelStyle: TextStyle(fontSize: 11.sp),
        ),
      ),
      home: const SplashPage(),
      builder: FlutterSmartDialog.init(
          //default toast widget
          //toastBuilder: (String msg) => CustomToastWidget(msg: msg),
          //default loading widget
          //loadingBuilder: (String msg) => Container(color: Colors.amber,),
          //default notify widget
          //notifyStyle: FlutterSmartNotifyStyle(
          //  successBuilder: (String msg) => CustomSuccessWidget(msg: msg),
          //  failureBuilder: (String msg) => CustomFailureWidget(msg: msg),
          //  warningBuilder: (String msg) => CustomWarningWidget(msg: msg),
          //  alertBuilder: (String msg) => CustomAlertWidget(msg: msg),
          //  errorBuilder: (String msg) => CustomErrorWidget(msg: msg),
          //),
          ),
    );
  }
}
