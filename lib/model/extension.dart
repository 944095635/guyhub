import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extension.g.dart';

enum ExtensionType {
  /// 漫画
  manga,

  /// 动画
  bangumi,

  /// 小说
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

enum ExtensionWatchBangumiType { hls, mp4, torrent }

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  late RxBool download = RxBool(false);

  /// 是否安装
  @JsonKey(includeFromJson: false, includeToJson: false)
  late RxBool install = RxBool(false);

  factory Extension.fromJson(Map<String, dynamic> json) =>
      _$ExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionToJson(this);
}

@JsonSerializable()
class ExtensionListItem {
  ExtensionListItem({
    required this.title,
    required this.url,
    this.cover,
    this.update,
    this.headers,
  });

  final String title;
  final String url;
  final String? cover;
  final String? update;
  late Map<String, String>? headers;

  factory ExtensionListItem.fromJson(Map<String, dynamic> json) =>
      _$ExtensionListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionListItemToJson(this);
}

@JsonSerializable()
class ExtensionDetail {
  ExtensionDetail({
    required this.title,
    this.cover,
    this.desc,
    this.episodes,
    this.headers,
  });

  final String title;
  final String? cover;
  final String? desc;
  final List<ExtensionEpisodeGroup>? episodes;
  late Map<String, String>? headers;

  factory ExtensionDetail.fromJson(Map<String, dynamic> json) =>
      _$ExtensionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionDetailToJson(this);
}

@JsonSerializable()
class ExtensionEpisodeGroup {
  ExtensionEpisodeGroup({
    required this.title,
    required this.urls,
  });
  final String title;
  final List<ExtensionEpisode> urls;

  factory ExtensionEpisodeGroup.fromJson(Map<String, dynamic> json) =>
      _$ExtensionEpisodeGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionEpisodeGroupToJson(this);
}

@JsonSerializable()
class ExtensionEpisode {
  ExtensionEpisode({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;

  factory ExtensionEpisode.fromJson(Map<String, dynamic> json) =>
      _$ExtensionEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionEpisodeToJson(this);
}

@JsonSerializable()
class ExtensionBangumiWatch {
  ExtensionBangumiWatch({
    required this.type,
    required this.url,
    this.subtitles,
    this.headers,
    this.audioTrack,
  });
  final ExtensionWatchBangumiType type;
  final String url;
  final List<ExtensionBangumiWatchSubtitle>? subtitles;
  late Map<String, String>? headers;
  late String? audioTrack;

  factory ExtensionBangumiWatch.fromJson(Map<String, dynamic> json) =>
      _$ExtensionBangumiWatchFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionBangumiWatchToJson(this);
}

@JsonSerializable()
class ExtensionBangumiWatchSubtitle {
  final String? language;
  final String title;
  final String url;
  ExtensionBangumiWatchSubtitle({
    required this.title,
    required this.url,
    this.language,
  });

  factory ExtensionBangumiWatchSubtitle.fromJson(Map<String, dynamic> json) =>
      _$ExtensionBangumiWatchSubtitleFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionBangumiWatchSubtitleToJson(this);
}

@JsonSerializable()
class ExtensionMangaWatch {
  ExtensionMangaWatch({
    required this.urls,
    this.headers,
  });

  final List<String> urls;
  late Map<String, String>? headers;

  factory ExtensionMangaWatch.fromJson(Map<String, dynamic> json) =>
      _$ExtensionMangaWatchFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionMangaWatchToJson(this);
}

@JsonSerializable()
class ExtensionFikushonWatch {
  final List<String> content;
  final String title;
  final String? subtitle;
  ExtensionFikushonWatch({
    required this.content,
    required this.title,
    this.subtitle,
  });

  factory ExtensionFikushonWatch.fromJson(Map<String, dynamic> json) =>
      _$ExtensionFikushonWatchFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionFikushonWatchToJson(this);
}
