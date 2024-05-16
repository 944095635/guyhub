import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/splash/splash_page.dart';
import 'package:guyhub/style/theme.dart';

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
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        extensions: [MyTheme.light],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Color(0xFF252525),
          //primaryContainer: Colors.amber,
          //  onPrimary: Colors.red,
          // secondary: Colors.red,
          //  onSecondary: Colors.amber,
        ),
        useMaterial3: true,
        //scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark, //状态栏黑色图标
            systemNavigationBarColor: Colors.white,
          ),
        ),
        tabBarTheme: TabBarTheme(
          //dividerHeight: 0,
          dividerColor: Colors.white,
          tabAlignment: TabAlignment.start,
          //labelStyle: TextStyle(
          //  fontFamily: "AvantGarde",
          //),
          //unselectedLabelStyle:TextStyle(
          //  fontFamily: "AvantGarde",
          //),
          indicator: const BoxDecoration(
            border: Border(
              // 划线位置、线宽、颜色
              bottom: BorderSide(width: 2.0),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(fontSize: 13.sp),
          unselectedLabelStyle: TextStyle(fontSize: 13.sp),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size.fromHeight(46.h)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
            ),
            backgroundColor: const WidgetStatePropertyAll(Color(0xFF252525)),
          ),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        ),
      ),
      darkTheme: ThemeData(
        extensions: [MyTheme.dark],
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light, //状态栏黑色图标
            systemNavigationBarColor: Colors.black,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: TextStyle(fontSize: 11.sp),
          unselectedLabelStyle: TextStyle(fontSize: 11.sp),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
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
