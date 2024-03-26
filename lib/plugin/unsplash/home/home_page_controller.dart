import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guyhub/plugin/unsplash/model/upsplash_image.dart';
import 'package:guyhub/util/http.dart';

class HomePageController extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  //List<UpsplashImage> data = List.empty(growable: true);
  int pageIndex = 0;
  String urlKey = "";

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 10, vsync: this);
    value = List.empty(growable: true);
    loadData();
  }

  //https://unsplash.com/napi/photos?page=1&per_page=10
  Future loadData() async {
    if (status.isLoading) {
      return;
    }
    change(value, status: RxStatus.loading());
    pageIndex++;
    String url =
        "https://unsplash.com/napi$urlKey/photos?page=$pageIndex&per_page=10";
    ServiceResultData result = await Http.get(url);
    if (result.success) {
      //String body = utf8.decode(response.bodyBytes);
      //debugPrint(body);
      List<dynamic> obj = json.decode(result.data);
      for (var item in obj) {
        UpsplashImage image = UpsplashImage.fromJson(item);
        value.add(image);
      }
      change(value, status: RxStatus.success());
    } else {
      change(value, status: RxStatus.error());
    }
  }

  //https://unsplash.com/napi/photos?page=3&per_page=10
  //https://unsplash.com/napi/topics/spring/photos?page=3&per_page=10
  void changeType(int index) {
    pageIndex = 0;
    value.clear();
    switch (index) {
      case 0:
        urlKey = '';
        break;
      case 1:
        urlKey = "/topics/nature";
      default:
    }
    loadData();
  }
}
