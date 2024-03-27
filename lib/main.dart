import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:guyhub/page/splash/splash_page.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/widget/common.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  MediaKit.ensureInitialized();
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
      theme: ThemeData(
        extensions: [MyTheme.light],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          //primary: Colors.amber,
          //primaryContainer: Colors.amber,
          //onPrimary: Colors.red,
          //secondary: Colors.red,
          //onSecondary: Colors.amber,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        //scaffoldBackgroundColor: Colors.white,
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
        textTheme: TextTheme(
          //Appbar
          titleLarge: TextStyle(fontSize: 18.sp),

          //titleMedium: TextStyle(fontSize: 33),
          //bodyLarge:  TextStyle(fontSize: 23),
          //bodyMedium:  TextStyle(fontSize: 23),
          //displayLarge:   TextStyle(fontSize: 23),
          //displayMedium:  TextStyle(fontSize: 23),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: glassColor,
          //showSelectedLabels: false,
          //showUnselectedLabels: false,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(fontSize: 11.sp),
          unselectedLabelStyle: TextStyle(fontSize: 11.sp),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        extensions: [MyTheme.dark],
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
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
