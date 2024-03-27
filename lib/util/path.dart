import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PathUtils {
  static late String extensionsDir;

  static Future ensureInitialized() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    extensionsDir = path.join(appDocDir.path, 'extensions');
    // 创建插件目录
    Directory(extensionsDir).createSync(recursive: true);
  }
}
