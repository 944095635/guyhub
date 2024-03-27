import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extension.g.dart';

enum ExtensionType {
  manga,
  bangumi,
  fikushon;

  @override
  String toString() {
    switch (this) {
      case ExtensionType.manga:
        return "漫画";
      case ExtensionType.fikushon:
        return "小说";
      case ExtensionType.bangumi:
        return "动画";
      default:
    }
    return "";
  }
}

@JsonSerializable()
class Extension {
  Extension({
    required this.package,
    required this.author,
    required this.version,
    required this.lang,
    required this.license,
    required this.type,
    required this.webSite,
    required this.name,
    this.icon,
    this.url,
    this.description,
  });

  /// 少儿不宜
  late String? nsfw;
  final String package;
  final String author;
  final String version;
  final String lang;
  final String license;
  final ExtensionType type;
  final String webSite;
  final String name;
  String? icon;
  String? url;
  String? description;

  /// 正在下载
  late RxBool download = RxBool(false);

  /// 是否安装
  late RxBool install = RxBool(false);

  factory Extension.fromJson(Map<String, dynamic> json) =>
      _$ExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionToJson(this);
}
