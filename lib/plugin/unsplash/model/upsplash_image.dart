import 'package:guyhub/plugin/unsplash/model/upsplash_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsplash_image.g.dart';

@JsonSerializable()
class UpsplashImage {
  late UpsplashUser user;

  late dynamic urls;

  late int height;

  late int width;

  UpsplashImage();

  factory UpsplashImage.fromJson(Map<String, dynamic> json) =>
      _$UpsplashImageFromJson(json);

  Map<String, dynamic> toJson() => _$UpsplashImageToJson(this);
}
