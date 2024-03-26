// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsplash_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsplashImage _$UpsplashImageFromJson(Map<String, dynamic> json) =>
    UpsplashImage()
      ..user = UpsplashUser.fromJson(json['user'] as Map<String, dynamic>)
      ..urls = json['urls']
      ..height = json['height'] as int
      ..width = json['width'] as int;

Map<String, dynamic> _$UpsplashImageToJson(UpsplashImage instance) =>
    <String, dynamic>{
      'user': instance.user,
      'urls': instance.urls,
      'height': instance.height,
      'width': instance.width,
    };
