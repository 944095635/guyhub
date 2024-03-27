import 'dart:io';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/util/http.dart';
import 'package:guyhub/util/path.dart';
import 'package:path/path.dart' as path;

class ExtensionUtils {
  /// 已经安装的所有插件
  static late List<String> setups;

  static late List<Extension> _extensions;

  static void ensureInitialized() {
    setups = [];
    _extensions = [];
    _loadExtension();
  }

  /// 安装插件
  static Future<bool> install(String url) async {
    var result = await Http.get(url);
    if (result.success) {
      final ext = ExtensionUtils.parseExtension(result.data);
      final savePath = path.join(PathUtils.extensionsDir, '${ext.package}.js');
      // 保存文件
      File(savePath).writeAsStringSync(result.data);
      _loadExtension();
      return true;
    }
    return false;
  }

  /// 卸载插件
  static Future<bool> uninstall(Extension ext) async {
    final file = File(path.join(PathUtils.extensionsDir, '${ext.package}.js'));
    try {
      if (await file.exists()) {
        await file.delete();
      }
      setups.remove(ext.package);
      return true;
    } catch (e) {
      //
    }
    return false;
  }

  /// 重新读取插件列表
  static void _loadExtension() async {
    setups.clear();
    _extensions.clear();
    // 获取扩展列表
    final extensionsList = Directory(PathUtils.extensionsDir).listSync();
    // 遍历扩展列表
    for (final extension in extensionsList) {
      if (path.extension(extension.path) == '.js') {
        final file = File(extension.path);
        final content = await file.readAsString();
        // 如果文件名和包名不一致，抛出异常
        final ext = ExtensionUtils.parseExtension(content);
        setups.add(ext.package);
        _extensions.add(ext);
      }
    }
  }

  static List<Extension> getExtensions() {
    return _extensions;
  }

  // ==MiruExtension==
  // @name         Enime
  // @version      v0.0.1
  // @author       MiaoMint
  // @lang         all
  // @license      MIT
  // @icon         https://avatars.githubusercontent.com/u/74993083?s=200&v=4
  // @package      moe.enime
  // @type         bangumi
  // @webSite      https://api.enime.moe/
  // @description  Enime API is an open source API service for developers to access anime info (as well as their video sources) https://github.com/Enime-Project/api.enime.moe
  // ==/MiruExtension==

  // 解析扩展为元数据
  static Extension parseExtension(String extension) {
    Map<String, dynamic> result = {};
    RegExp exp = RegExp(r'@(\w+)\s+(.*)');
    Iterable<RegExpMatch> matches = exp.allMatches(extension);
    for (RegExpMatch match in matches) {
      result[match.group(1)!] = match.group(2);
    }
    //result['nsfw'] = result['nsfw'] == "true";
    return Extension.fromJson(result);
  }
}
