import 'package:json_annotation/json_annotation.dart';

part 'upsplash_user.g.dart';

@JsonSerializable()
class UpsplashUser {
  late String name;

  @JsonKey(name: "profile_image")
  late dynamic profileImage;

  UpsplashUser();

  factory UpsplashUser.fromJson(Map<String, dynamic> json) =>
      _$UpsplashUserFromJson(json);

  Map<String, dynamic> toJson() => _$UpsplashUserToJson(this);
}
