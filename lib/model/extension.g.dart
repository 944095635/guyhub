// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extension.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Extension _$ExtensionFromJson(Map<String, dynamic> json) => Extension(
      package: json['package'] as String,
      author: json['author'] as String,
      version: json['version'] as String,
      lang: json['lang'] as String,
      license: json['license'] as String,
      type: $enumDecode(_$ExtensionTypeEnumMap, json['type']),
      webSite: json['webSite'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
    )..nsfw = json['nsfw'] as String?;

Map<String, dynamic> _$ExtensionToJson(Extension instance) => <String, dynamic>{
      'nsfw': instance.nsfw,
      'package': instance.package,
      'author': instance.author,
      'version': instance.version,
      'lang': instance.lang,
      'license': instance.license,
      'type': _$ExtensionTypeEnumMap[instance.type]!,
      'webSite': instance.webSite,
      'name': instance.name,
      'icon': instance.icon,
      'url': instance.url,
      'description': instance.description,
    };

const _$ExtensionTypeEnumMap = {
  ExtensionType.manga: 'manga',
  ExtensionType.bangumi: 'bangumi',
  ExtensionType.fikushon: 'fikushon',
};
